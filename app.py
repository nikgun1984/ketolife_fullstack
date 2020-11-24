import os
from flask import Flask, render_template, request, flash, redirect, session, g, jsonify, url_for
from flask_debugtoolbar import DebugToolbarExtension
from functools import wraps
import requests
# import wtforms_json

# Initialize wtforms_json
# wtforms_json.init()

from models import db, connect_db, User,Recipe
from forms import NutritionTranslatorForm
from secrets import APP_KEY

CURR_USER_KEY = "curr_user"

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

# @app.context_processor
# def context_processor():
#     """Nutrition Keys"""
#     app_id = '0d4e7346'
#     app_key = 'aff718186734870cfd586adf4bf8887e'
#     return dict(app_id=app_id,app_key=app_key)

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
    return render_template("index.html")

# @app.route("/api/get-nutrition-food", methods=["GET","POST"])
# def get_food_nutrition():
#     query = request.form["text"]
#     resp = requests.get("https://api.edamam.com/api/nutrition-data", params={"app_id":APP_ID,"app_key":APP_KEY,"ingr":query})
#     return resp.json()

@app.route("/api/get-ingredient-info", methods=["GET","POST"])
def get_ingredient_info():
    query = request.get_json()
    # import pdb
    # pdb.set_trace()
    resp = requests.get(f"https://api.spoonacular.com/food/ingredients/search", params={"apiKey":APP_KEY,"query":query['ing']})
    res = resp.json()
    lst = {res['results'][i]["name"]:res['results'][i]["id"] for i in range(len(res['results']))}
    # import pdb
    # pdb.set_trace()
    return jsonify(lst)
        


    

