import os, math
from flask import Flask, render_template, request, flash, redirect, session, g, jsonify, url_for, send_file
from flask_debugtoolbar import DebugToolbarExtension
from functools import wraps
import requests
from sqlalchemy.exc import IntegrityError
from flask_wtf.csrf import CSRFProtect
import json
from io import BytesIO

from models import db, connect_db, User,Recipe, Product, Rating
from forms import NewRecipeForm, TitleRecipeForm, LoginForm, UserAddForm
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE, key_gen
import utilities

CURR_USER_KEY = "curr_user"
BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"
BASE_IMG_LINK = "https://spoonacular.com/cdn/ingredients_250x250";

csrf = CSRFProtect()
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = (
    os.environ.get('DATABASE_URL', 'postgres:///keto_life'))
app.config["SEND_FILE_MAX_AGE_DEFAULT"] = 0
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = False
# app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = True
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', key_gen)
# Disable pre-request CSRF
app.config["WTF_CSRF_CHECK_DEFAULT"] = False

# Check csrf for session and http auth (but not token)
app.config["SECURITY_CSRF_PROTECT_MECHANISMS"] = ["session", "basic"]
# toolbar = DebugToolbarExtension(app)

csrf.init_app(app)
connect_db(app)

@app.context_processor
def context_processor():
    """Now forms will be available globally across all jinja templates"""
    login_form = LoginForm()
    signup_form = UserAddForm()
    classes = ["fa fa-user","fa fa-paper-plane","fa fa-lock","fa fa-check-circle"]
    return dict(login_form=login_form,signup_form=signup_form,classes=classes)

######################### Users Methods ######################################

@app.before_request
def add_user_to_g():
    """If we're logged in, add curr user to Flask global."""

    if CURR_USER_KEY in session:
        g.user = User.query.get(session[CURR_USER_KEY])

    else:
        g.user = None


def do_login(user):
    """Log in user."""
    session[CURR_USER_KEY] = user.id

def login_required(f):
    """Need an authorization to create/logout etc for certain app features"""
    @wraps(f)
    def wrap(*args,**kwargs):
        if CURR_USER_KEY in session:
            return f(*args,**kwargs)
        else:
            flash("Access unauthorized.", "success")
            return redirect("/")
    return wrap

def do_logout():
    """Logout user."""

    if CURR_USER_KEY in session:
        del session[CURR_USER_KEY]

@app.route('/signup', methods= ["POST"])
def signup():
    """Handle user signup.
    Create new user and add to DB. Redirect to home user's page.
    If form not valid, present form.
    If the there already is a user with that username: flash message
    and re-present form.
    """
    signup_form = UserAddForm()
    if signup_form.validate_on_submit():
        username = signup_form.username.data
        password = signup_form.password.data
        email = signup_form.email.data
        confirm = signup_form.password_check.data
        image_url = User.image_url.default.arg
        try:
            user = User.signup(username=username,password=password,email=email,image_url=image_url)
            flash(f"Welcome {user.username}!!!")
        except IntegrityError:
            flash("Username already taken")
            return redirect("/")
        do_login(user)
        return redirect("/")
    flash("Password does not match confirmed password")
    return redirect("/")

@app.route('/login', methods=["POST"])
def login():
    """Handle user login."""
    login_form = LoginForm()

    if login_form.validate_on_submit():
        user = User.authenticate(login_form.email_ver.data,
                                    login_form.password_ver.data)
        if not user:
            flash("Invalid credentials.")
            return redirect('/')
        do_login(user)
        flash(f"Hello, {user.username}!")
        return redirect("/")
    flash(f"Wrong credentials")
    return redirect("/")


@app.route('/logout')
@login_required
def logout():
    """Handle logout of user."""
    name = g.user.username
    do_logout()
    flash(f"See you later, {name}!!!")
    return redirect('/')

######################################################

@app.route("/")
def homepage():
    """Show homepage."""
    recipes = db.session.query(Recipe).order_by(Recipe.id.desc()).limit(15).all()[::-1]
    veggies = utilities.partition_list(db.session.query(Product).filter_by(product_type='veggies').all(),6)
    fruits = utilities.partition_list(db.session.query(Product).filter_by(product_type='fruits').all(),6)
    nuts_seeds = utilities.partition_list(Product.query.filter(db.or_(Product.product_type == 'nuts', Product.product_type == 'seeds')).all(),6)
    fats_oils = utilities.partition_list(Product.query.filter(db.or_(Product.product_type == 'healthy fats', Product.product_type == 'healthy oils')).all(),6)
    sweeteners = utilities.partition_list(db.session.query(Product).filter_by(product_type='sweetener').all(),6)
    
    result_rec = utilities.get_carousel_card_info(recipes)
    return render_template("index.html", recipes=result_rec, veggies=veggies, fruits=fruits, nuts_seeds=nuts_seeds,fats_oils=fats_oils,sweeteners=sweeteners,flag=True,state='active')

###### Ingredients Routes ######################################################
@app.route("/api/get-ingredient")
def get_ingredient_id():
    """Need to get ingredient ID in order to access all attributes"""

    query = request.args["text"]
    resp = requests.get(f"{BASE_URL_SP}/food/ingredients/search?", params={"apiKey":APP_KEY,"query":query})
    res = resp.json()
    lst = {res['results'][i]["name"]:res['results'][i]["id"] for i in range(len(res['results']))}
    return jsonify(lst)

@app.route("/api/get-ingredient/<id>")
def get_ingredient_info(id):
    """Resp: name, units, category"""

    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY})
    res = resp.json()
    lst = [unit for unit in res['possibleUnits']]
    category = res['categoryPath']
    return jsonify(units=lst,img=res['image'],name=res['name'],id=id,category=category)

@app.route("/api/get-ingredient/<id>/info")
def ingredient_nutrifacts(id):
    """Nutritional Data of an ingredient"""

    unit = request.args.get('units')
    amount = request.args.get('amount')
    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY,"amount":amount,"unit":unit})
    res = resp.json()
    name = res["name"].capitalize()
    img = f"{BASE_IMG_LINK}/{res['image']}"
    category = res["categoryPath"]
    cost = round(res['estimatedCost']['value']/100,3)
    nutrients,vitamins = utilities.split_nutritional_fact_data(res['nutrition']['nutrients'])
    fats,carbs,no_daily = utilities.get_fats_carbs()
    unit = res['unit']

    return render_template("ingredient-info.html", name=name,cost=cost,nutrients=nutrients,vitamins=vitamins,unit=unit, amount=amount,carbs=carbs,fats=fats,no_daily=no_daily,img=img,category=category,nutri = list(nutrients),vit=list(vitamins))

@app.route("/api/get-ingredient/<id>/nutrifacts")
def get_ingredient_for_recipe(id):
    unit = request.args.get('units')
    amount = request.args.get('amount')
    nutrients_total = request.args.get('nutrients')
    vitamins_total = request.args.get('vitamins')
    servings = int(request.args.get('serving'))
    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY,"amount":amount,"unit":unit})
    res = resp.json()
    nutr,vits = utilities.split_nutritional_fact_data(res['nutrition']['nutrients'])
    nutrients = utilities.calculate_per_serving(nutr,servings)
    vitamins = utilities.calculate_per_serving(vits,servings)
    if nutrients_total and vitamins_total:
        nutrients_total = json.loads(nutrients_total)
        vitamins_total = json.loads(vitamins_total)
        nutrients_total = utilities.add_nutrients(nutrients_total,nutrients)
        vitamins_total = utilities.add_nutrients(vitamins_total,vitamins)
    else:
        nutrients_total = nutrients
        vitamins_total = vitamins
    return jsonify(nutrients,vitamins, nutrients_total, vitamins_total)

@app.route('/api/delete-ingredient')
@login_required
def delete_ingredient_from_recipe():
    nutrients = json.loads(request.args.get('nutrients'))
    vitamins = json.loads(request.args.get('vitamins'))
    total_nutrients = json.loads(request.args.get('total_nutrients'))
    total_vitamins = json.loads(request.args.get('total_vitamins'))
    total_nutrients = utilities.subtract_nutrients(total_nutrients,nutrients)
    total_vitamins = utilities.subtract_nutrients(total_vitamins,vitamins)
    return jsonify(total_nutrients, total_vitamins)
    
@app.route('/api/get-recipe-database/<int:id>')
def get_recipe_database(id):
    recipe = Recipe.query.get(id)
    if not recipe:
        flash(f"Recipe Not Found...")
        return redirect('/')
    avg_rate = utilities.calculate_average_rating(id,recipe.average_rate)
    user_rating = utilities.is_empty_query(id)
    percentages = utilities.calculate_percentages_stars(id)
    nutrients,vitamins = utilities.get_nutrients_recipe(recipe,recipe.servings)
    fats = tuple(["Trans Fat","Saturated Fat","Saturated","Trans","Polyunsaturated","Mono Unsaturated Fat","Poly Unsaturated Fat","Monounsaturated"])
    carbs = tuple(["Sugar Alcohol","Sugar","Fiber","Net Carbohydrates","Sugars", "Carbs (net)",'Sugar alcohols','Sugars, added'])
    no_daily = tuple(["Sugar","Sugars",'Sugars, added','Protein','Monounsaturated','Polyunsaturated'])
    calories = math.ceil(recipe.calories/recipe.servings)

    return render_template("recipe-check.html", recipe=recipe, nutrients=nutrients, vitamins=vitamins,fats=fats,carbs=carbs,calories=calories,no_daily=no_daily, user_rating=user_rating, percentages=percentages)

@app.route('/api/get-recipe')
def get_recipe():
    """Get all possible recipes for query"""
    query_string = request.args.get("search-bar")
    # resp = requests.get(f'{BASE_URL_ED}/search?', params={'q':f'keto {query_string}',"app_id":APP_ID_RECIPE,"app_key":APP_KEY_RECIPE,"healt":'keto-friendly',"from":0,"to":20})
    # save_recipe_to_database(resp)
    rec = Recipe.query.filter(Recipe.title.ilike(f"%{query_string}%")).all()
    size = len(rec)
    recipes = utilities.partition_list(rec,3)
    n_carbs = utilities.partition_list(utilities.calculate_all_recipes_netcarbs(rec),3)
    return render_template('recipe-result.html', recipes=recipes, size=size, n_carbs=n_carbs)

@app.route('/api/your-best-recipes')
@login_required
def get_best_rated():
    """Get all best rated recipes """
    best_rated, user_ratings, net_carbs = utilities.get_best_rated_recipes()
    best = utilities.partition_list(best_rated,3)
    u_rated = utilities.partition_list(user_ratings,3)
    n_carbs = utilities.partition_list(net_carbs,3)
    size = len(best_rated)
    return render_template('best-rated-recipes.html',best_rated=best, user_ratings=u_rated,size=size,net_carbs=n_carbs)

#### Need to work on this one just yet
@app.route('/api/get-instructions')
def get_instructions():
    """Extract Data From Website"""
    url = request.args.get('url')
    resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
    return jsonify(resp.json())
##############################################

@app.route('/api/add-rating', methods=["POST"])
@login_required
def add_ratings():
    """Add rating to the recipe only if logged in"""
    recipe_id = int(request.json['recipe_id'])
    rating = int(request.json['rating'])
    utilities.is_already_rated(recipe_id,rating)
    percentages = utilities.calculate_percentages_stars(recipe_id)
    avg_rate = utilities.calculate_average_rating(recipe_id,rating)
    return jsonify(avg_rate,percentages)

@app.route('/api/create-recipe')
@login_required
def get_create_recipe_form():
    """Create a new recipe and add it to the database"""
    form = TitleRecipeForm()

    if form.title.validate(form):
        title = form.title.data
    return render_template('create-recipe.html',form=form)

@app.route('/api/submit-recipe', methods=["POST"])
@login_required
def submit_recipe():
    """Create Recipe and Add it to database"""
    file = request.files.get('file')
    other_data = json.loads(request.form.get('otherData'))
    new_recipe = utilities.handle_adding_recipe_data(other_data,file)
    
    return jsonify(new_recipe.id)

@app.route('/images/<int:recipe_id>.png')
def get_image(recipe_id):
    recipe = Recipe.query.get(recipe_id)
    image_binary = recipe.local_image
    return send_file(BytesIO(image_binary),as_attachment=False, attachment_filename=f'{recipe_id}.png')