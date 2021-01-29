from flask import render_template
#################################
from app import app
from utilities import ingredient_utility as util, recipe_utility as r_util
from models import db, Recipe, Product


@app.route("/")
def homepage():
    """Show homepage."""
   
    recipes = db.session.query(Recipe).order_by(Recipe.id.desc()).limit(15).all()[::-1]
    veggies = util.partition_list(db.session.query(Product).filter_by(product_type='veggies').all(),6)
    fruits = util.partition_list(db.session.query(Product).filter_by(product_type='fruits').all(),6)
    nuts_seeds = util.partition_list(Product.query.filter(db.or_(Product.product_type == 'nuts', Product.product_type == 'seeds')).all(),6)
    fats_oils = util.partition_list(Product.query.filter(db.or_(Product.product_type == 'healthy fats', Product.product_type == 'healthy oils')).all(),6)
    sweeteners = util.partition_list(db.session.query(Product).filter_by(product_type='sweetener').all(),6)
    
    result_rec = r_util.get_carousel_card_info(recipes)
    return render_template("index.html", recipes=result_rec, veggies=veggies, fruits=fruits, nuts_seeds=nuts_seeds,fats_oils=fats_oils,sweeteners=sweeteners,flag=True,state='active')
