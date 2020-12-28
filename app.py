import os, math
from flask import Flask, render_template, request, flash, redirect, session, g, jsonify, url_for
from flask_debugtoolbar import DebugToolbarExtension
from functools import wraps
import requests
from sqlalchemy.exc import IntegrityError
from flask_wtf.csrf import CSRFProtect


from models import db, connect_db, User,Recipe, Product, Rating
from forms import NewRecipeForm, TitleRecipeForm, LoginForm, UserAddForm
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE, key_gen
from utilities import get_carousel_card_info, partition_list, split_nutritional_fact_data, get_nutrients_recipe, save_recipe_to_database, calculate_average_rating, get_best_rated_recipes, is_already_rated, is_empty_query, calculate_percentages_stars, calculate_all_recipes_netcarbs, calculate_per_serving

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

@app.route("/")
def homepage():
    """Show homepage."""
    recipes = db.session.query(Recipe).order_by(Recipe.id.desc()).limit(15).all()[::-1]
    veggies = partition_list(db.session.query(Product).filter_by(product_type='veggies').all(),6)
    fruits = partition_list(db.session.query(Product).filter_by(product_type='fruits').all(),6)
    nuts_seeds = partition_list(Product.query.filter(db.or_(Product.product_type == 'nuts', Product.product_type == 'seeds')).all(),6)
    fats_oils = partition_list(Product.query.filter(db.or_(Product.product_type == 'healthy fats', Product.product_type == 'healthy oils')).all(),6)
    sweeteners = partition_list(db.session.query(Product).filter_by(product_type='sweetener').all(),6)
    
    result_rec = get_carousel_card_info(recipes)
    return render_template("index.html", recipes=result_rec, veggies=veggies, fruits=fruits, nuts_seeds=nuts_seeds,fats_oils=fats_oils,sweeteners=sweeteners,flag=True,state='active')

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

@app.route('/api/create-recipe', methods=['GET','POST'])
@login_required
def get_create_recipe_form():
    """Create a new recipe and add it to the database"""
    form = TitleRecipeForm()

    if form.title.validate(form):
        title = form.title.data
    # if form.validate_on_submit():
    #     # gotta handle ingredients and instructions somehow (lists)
    #     ingredients = form.ingredients.data 
    #     instructions = form.instructions.data
    #     # everything else is str8-forward
    #     title = form.title.data
    #     servings = form.servings.data
    #     time_prep = form.time_prep.data
    #     time_cook = form.time_cook.data
    #     image = form.image.data
    #     cuisine_type = form.cuisine_type.data
    #     dish_type = form.dish_type.data
    #     meal_type = form.meal_type.data

    #     new_recipe = Recipe(title=title,serving=serving,
    #                         time_prep=time_prep,
    #                         time_cook=time_cook,image=image,
    #                         cuisine_type=cuisine_type,dish_type=dish_type,
    #                         meal_type=meal_type)
    #     new_recipe.ingredients.extend(ingredients)
    #     new_recipe.instructions.extend(instructions)
    #     db.session.add(new_recipe)
    #     db.session.commit()
    #     serialized = new_recipe.serialize()
    #     return jsonify(recipe=serialized), 201
    return render_template('create-recipe.html',form=form)

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
    nutrients,vitamins = split_nutritional_fact_data(res['nutrition']['nutrients'])
    # import pdb
    # pdb.set_trace()
    fats = tuple(["Trans Fat","Saturated Fat","Mono Unsaturated Fat","Poly Unsaturated Fat"])
    carbs = tuple(["Sugar Alcohol","Sugar","Net Carbohydrates","Sugars","Carbs (net)",'Sugar alcohols','Sugars, added'])
    no_daily = tuple(["Sugar","Sugars",'Sugars, added','Protein'])
    unit = res['unit']

    return render_template("ingredient-info.html", name=name,cost=cost,nutrients=nutrients,vitamins=vitamins,unit=unit, amount=amount,carbs=carbs,fats=fats,no_daily=no_daily,img=img,category=category,nutri = list(nutrients),vit=list(vitamins))

@app.route("/api/get-ingredient/<id>/nutrifacts")
def get_ingredient_for_recipe(id):
    unit = request.args.get('units')
    amount = request.args.get('amount')
    servings = int(request.args.get('serving'))
    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY,"amount":amount,"unit":unit})
    res = resp.json()
    nutr,vits = split_nutritional_fact_data(res['nutrition']['nutrients'])
    nutrients = calculate_per_serving(nutr,servings)
    vitamins = calculate_per_serving(vits,servings)
    return jsonify(nutrients,vitamins)

@app.route('/api/get-recipe-database/<int:id>')
def get_recipe_database(id):
    recipe = Recipe.query.get(id)
    avg_rate = calculate_average_rating(id,recipe.average_rate)
    user_rating = is_empty_query(id)
    percentages = calculate_percentages_stars(id)
    # import pdb
    # pdb.set_trace()
    nutrients,vitamins = get_nutrients_recipe(recipe,recipe.servings)
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
    recipes = partition_list(rec,3)
    n_carbs = partition_list(calculate_all_recipes_netcarbs(rec),3)
    return render_template('recipe-result.html', recipes=recipes, size=size, n_carbs=n_carbs)

@app.route('/api/your-best-recipes')
@login_required
def get_best_rated():
    """Get all best rated recipes """
    best_rated, user_ratings, net_carbs = get_best_rated_recipes()
    best = partition_list(best_rated,3)
    u_rated = partition_list(user_ratings,3)
    n_carbs = partition_list(net_carbs,3)
    size = len(best_rated)
    return render_template('best-rated-recipes.html',best_rated=best, user_ratings=u_rated,size=size,net_carbs=n_carbs)

@app.route('/api/get-instructions')
def get_instructions():
    """Get directions and time for preparation and cooking data"""

    url = request.args.get('url')
    resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
    import pdb
    pdb.set_trace()
    return jsonify(resp.json())

@app.route('/api/add-rating', methods=["POST"])
@login_required
def add_ratings():
    recipe_id = int(request.json['recipe_id'])
    rating = int(request.json['rating'])
    is_already_rated(recipe_id,rating)
    percentages = calculate_percentages_stars(recipe_id)
    avg_rate = calculate_average_rating(recipe_id,rating)
    return jsonify(avg_rate,percentages)









    




