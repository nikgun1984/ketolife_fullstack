import os, math
from flask import Flask, render_template, request, flash, redirect, session, g, jsonify, url_for
from flask_debugtoolbar import DebugToolbarExtension
from functools import wraps
import requests
from sqlalchemy.exc import IntegrityError

# import wtforms_json

# Initialize wtforms_json
# wtforms_json.init()

from models import db, connect_db, User,Recipe, Product
from forms import NewRecipeForm, TitleRecipeForm, LoginForm, UserAddForm
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
from utilities import get_carousel_card_info, partition_list, split_nutritional_fact_data, get_nutrients_recipe, save_recipe_to_database

CURR_USER_KEY = "curr_user"
BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"
BASE_IMG_LINK = "https://spoonacular.com/cdn/ingredients_250x250";

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = (
    os.environ.get('DATABASE_URL', 'postgres:///keto_life'))
app.config["SEND_FILE_MAX_AGE_DEFAULT"] = 0
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = False
# app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = True
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', "it's a secret")
# toolbar = DebugToolbarExtension(app)

connect_db(app)

@app.context_processor
def context_processor():
    """Now forms will be available globally across all jinja templates"""
    login_form = LoginForm()
    signup_form = UserAddForm()
    return dict(login_form=login_form,signup_form=signup_form)

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
    """Need an authorization to create/delete etc for certain app features"""

    @wraps(f)
    def wrap(*args,**kwargs):
        if CURR_USER_KEY in session:
            return f(*args,**kwargs)
        else:
            flash("Access unauthorized.", "danger")
            return redirect("/")
    return wrap

def do_logout():
    """Logout user."""

    if CURR_USER_KEY in session:
        del session[CURR_USER_KEY]

@app.route("/")
def homepage():
    """Show homepage."""
    recipes = Recipe.query.limit(11).all()
    veggies = partition_list(db.session.query(Product).filter_by(product_type='veggies').all(),6)
    fruits = partition_list(db.session.query(Product).filter_by(product_type='fruits').all(),6)
    nuts_seeds = partition_list(Product.query.filter(db.or_(Product.product_type == 'nuts', Product.product_type == 'seeds')).all(),6)
    fats_oils = partition_list(Product.query.filter(db.or_(Product.product_type == 'healthy fats', Product.product_type == 'healthy oils')).all(),6)
    sweeteners = partition_list(db.session.query(Product).filter_by(product_type='sweetener').all(),6)
    
    result_rec = get_carousel_card_info(recipes)
    # import pdb
    # pdb.set_trace()

    return render_template("index.html", recipes=result_rec, veggies=veggies, fruits=fruits, nuts_seeds=nuts_seeds,fats_oils=fats_oils,sweeteners=sweeteners,flag=True,state='active')

@app.route('/', methods= ["POST"])
def signup():
    """Handle user signup.
    Create new user and add to DB. Redirect to home user's page.
    If form not valid, present form.
    If the there already is a user with that username: flash message
    and re-present form.
    """
    signup_form = UserAddForm()
    if signup_form.validate_on_submit():
        username = request.json["username"]
        password = request.json["password"]
        email = request.json["email"]
        confirm = request.json["confirm"]
        image_url = User.image_url.default.arg
        try:
            user = User.signup(username=username,password=password,email=email,image_url=image_url)
            db.session.commit()
        except IntegrityError:
            flash("Username already taken", 'danger')
            return redirect("/")
        do_login(user)
        return jsonify(user=user.serialize()), 201
    # signup_form = UserAddForm()
    # if signup_form.validate_on_submit():
    #     try:
    #         user = User.signup(
    #             username = request.json["username"],
    #             password = request.json["password"],
    #             email = request.json["email"]
    #         )
    #         db.session.add(user)
    #         db.session.commit()
    #         return jsonify(user=user.serialize()), 201

    #     except IntegrityError:
    #         flash("Username already taken", 'danger')
    #         return redirect("/")

    #     do_login(user)

    #     return redirect("/")


@app.route('/login', methods=["POST"])
def login():
    """Handle user login."""
    user = User.authenticate(request.json["email"],
                                request.json["password"])
    if not user:
        flash("Invalid credentials.", 'danger')
        return redirect('/')
    do_login(user)
    flash(f"Hello, {user.username}!", "success")
    return jsonify(user_id = user.id,username = user.username), 201


@app.route('/logout')
@login_required
def logout():
    """Handle logout of user."""
    do_logout()
    flash("See you later, alligator!!!", "success")
    return redirect('/login')

@app.route('/api/create-recipe', methods=['GET','POST'])
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
    return render_template('create_recipe.html',form=form)

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

@app.route("/api/get-ingredient/<id>/nutrifacts")
def get_ingredient_nutrifacts(id):
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
    fats = set(["Trans Fat","Saturated Fat","Mono Unsaturated Fat","Poly Unsaturated Fat"])
    carbs = set(["Sugar Alcohol","Sugar","Fiber","Net Carbohydrates"])
    unit = res['unit']
    # import pdb
    # pdb.set_trace()
    return render_template("ingredient-info.html", name=name,cost=cost,nutrients=nutrients,vitamins=vitamins,unit=unit, amount=amount,carbs=carbs,fats=fats,img=img,category=category)

@app.route('/get-recipe-database/<int:id>')
def get_recipe_database(id):
    recipe = Recipe.query.get(id)
    nutrients,vitamins = get_nutrients_recipe(recipe,recipe.servings)
    fats = set(["Trans Fat","Saturated Fat","Saturated","Trans","Polyunsaturated","Mono Unsaturated Fat","Poly Unsaturated Fat","Monounsaturated"])
    carbs = set(["Sugar Alcohol","Sugar","Fiber","Net Carbohydrates"])
    calories = math.ceil(recipe.calories/recipe.servings)
    return render_template("recipe-check.html", recipe=recipe, nutrients=nutrients, vitamins=vitamins,fats=fats,carbs=carbs,calories=calories)

@app.route('/api/get-recipe')
def get_recipe():
    """Get all possible recipes for query"""
    query_string = request.args.get("search-bar")
    resp = requests.get(f'{BASE_URL_ED}/search?', params={'q':f'keto {query_string}',"app_id":APP_ID_RECIPE,"app_key":APP_KEY_RECIPE,"healt":'keto-friendly',"from":0,"to":20})
    save_recipe_to_database(resp)
    # import pdb
    # pdb.set_trace()
    rec = Recipe.query.filter(Recipe.title.ilike(f"%{query_string}%")).all()
    size = len(rec)
    recipes = partition_list(rec,3)
    # import pdb
    # pdb.set_trace() 
    return render_template('recipe-result.html', recipes=recipes, size=size)

@app.route('/api/get-instructions')
def get_instructions():
    """Get directions and time for preparation and cooking data"""

    url = request.args.get('url')
    resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
    import pdb
    pdb.set_trace()
    return jsonify(resp.json())






    




