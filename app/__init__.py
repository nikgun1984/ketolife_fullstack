################# Flask and SQLAlchemy
from flask import Flask
from flask_wtf.csrf import CSRFProtect
#####################################
from models import connect_db
####################################
app = Flask(__name__)

# which environment is used
if app.config["ENV"] == "production":
    app.config.from_object("config.ProductionConfig")
else:
    app.config.from_object("config.DevelopmentConfig")

# Init CSRF protection object to enable some form fields
csrf = CSRFProtect()
####################################
csrf.init_app(app)
connect_db(app)

# import all the views below Flask initialization to avoid circular import
from app import home_view, users_views, recipes_views, ingredients_views, errors_views
