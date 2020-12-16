import os
from flask import Flask, render_template, request, flash, redirect, session, g, jsonify, url_for
from flask_debugtoolbar import DebugToolbarExtension
from functools import wraps
import requests
from sqlalchemy.exc import IntegrityError

# import wtforms_json

# Initialize wtforms_json
# wtforms_json.init()

from models import db, connect_db, User,Recipe
from forms import NewRecipeForm, TitleRecipeForm, LoginForm, UserAddForm
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE

CURR_USER_KEY = "curr_user"
BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"

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
    """Now form will be available globally across all jinja templates"""
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

@app.route('/signup', methods= ["GET", "POST"])
def signup():
    """Handle user signup.
    Create new user and add to DB. Redirect to home user's page.
    If form not valid, present form.
    If the there already is a user with that username: flash message
    and re-present form.
    """

    form = UserAddForm()

    if form.validate_on_submit():
        try:
            user = User.signup(
                username=form.username.data,
                password=form.password.data,
                email=form.email.data,
                image_url=form.image_url.data
            )
            db.session.commit()

        except IntegrityError:
            flash("Username already taken", 'danger')
            return render_template('signup.html', user_form=form)

        do_login(user)

        return redirect("/")

    else:
        return render_template('signup.html', form=form)


@app.route('/login', methods=["GET", "POST"])
def login():
    """Handle user login."""

    form = LoginForm()

    if form.validate_on_submit():
        user = User.authenticate(form.username.data,
                                 form.password.data)

        if user:
            do_login(user)
            flash(f"Hello, {user.username}!", "success")
            return redirect("/")

        flash("Invalid credentials.", 'danger')

    return render_template('users/login.html', user_form=form)


@app.route('/logout')
@login_required
def logout():
    """Handle logout of user."""
    do_logout()
    flash("See you later, alligator!!!", "success")
    return redirect('/login')

@app.route("/")
def homepage():
    """Show homepage."""
    
    return render_template("index.html")

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
    cost = round(res['estimatedCost']['value']/100,3)
    nutrients = res['nutrition']['nutrients']
    unit = res['unit']
    return jsonify(cost=cost,nutrients=nutrients,unit=unit)

@app.route('/api/get-recipe')
def get_recipe():
    """Get all possible recipes for query"""

    query_string = request.args["search"]
    resp = requests.get(f'{BASE_URL_ED}/search?', params={'q':f'keto {query_string}',"app_id":APP_ID_RECIPE,"app_key":APP_KEY_RECIPE,"healt":'keto-friendly'})
    return jsonify(resp.json())

@app.route('/api/get-instructions')
def get_instructions():
    """Get directions and time for preparation and cooking data"""

    url = request.args.get('url')
    resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
    return jsonify(resp.json())




    




