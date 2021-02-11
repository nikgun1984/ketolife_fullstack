from flask_bcrypt import Bcrypt
from flask_sqlalchemy import SQLAlchemy

bcrypt = Bcrypt()
db = SQLAlchemy()

def connect_db(app):
    """Connect to our database"""
    db.app = app
    db.init_app(app)

from models.recipe import Recipe
from models.comment import Comment
from models.ingredient import Ingredient
from models.instruction import Instruction
from models.nutrient import Nutrient
from models.product import Product
from models.rating import Rating
from models.recipe_nutrient import RecipeNutrient
from models.unit import Unit
from models.user import User


