import os
from app import app
from forms import LoginForm, UserAddForm
from secrets import APP_KEY,APP_ID_RECIPE,APP_KEY_RECIPE

CURR_USER_KEY = "curr_user"
BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"
BASE_IMG_LINK = "https://spoonacular.com/cdn/ingredients_250x250";

BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"

APP_KEY = os.environ.get('APP_KEY',APP_KEY)
APP_ID_RECIPE = os.environ.get('APP_ID_RECIPE', APP_ID_RECIPE)
APP_KEY_RECIPE = os.environ.get('APP_KEY_RECIPE', APP_KEY_RECIPE)

@app.context_processor
def context_processor():
    """Now forms will be available globally across all jinja templates"""

    login_form = LoginForm()
    signup_form = UserAddForm()
    classes = ["fa fa-user","fa fa-paper-plane","fa fa-lock","fa fa-check-circle"]
    return dict(login_form=login_form,signup_form=signup_form,classes=classes)
    