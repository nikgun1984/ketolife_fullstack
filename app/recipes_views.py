################# Flask and SQLAlchemy
from flask import render_template, request, flash, redirect, session, g, jsonify, send_file
################ Other libraries
import json
from io import BytesIO
import math
import requests
################# Imported from external files
from app import app, access
from settings import CURR_USER_KEY,BASE_URL_SP,APP_KEY
from models import db, Recipe, Comment
from forms import TitleRecipeForm, CommentsForm
from utilities import nutrient_utility as n_util, ingredient_utility as in_util, user_utility as u_util, rating_utility as r_util, recipe_utility as rec_util


############ Recipe #################################################
@app.route("/api/get-ingredient/<id>/nutrifacts", methods=["POST"])
def get_ingredient_for_recipe(id):
    """Ingredient for Recipe"""
    data = request.json.get('body')
    unit = data.get('units')
    amount = data.get('amount')
    nutrients_total = data.get('nutrients')
    vitamins_total = data.get('vitamins')
    servings = int(data.get('serving'))
    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY,"amount":amount,"unit":unit})
    res = resp.json()
    nutr,vits = n_util.split_nutritional_fact_data(res['nutrition']['nutrients'])
    nutrients = n_util.calculate_per_serving(nutr,servings)
    vitamins = n_util.calculate_per_serving(vits,servings)
    if nutrients_total and vitamins_total:
        nutrients_total = json.loads(nutrients_total)
        vitamins_total = json.loads(vitamins_total)
        nutrients_total = n_util.add_nutrients(nutrients_total,nutrients)
        vitamins_total = n_util.add_nutrients(vitamins_total,vitamins)
    else:
        nutrients_total = nutrients
        vitamins_total = vitamins
    return jsonify(nutrients,vitamins, nutrients_total, vitamins_total)

@app.route('/api/get-recipe')
def get_recipe():
    """Get all possible recipes for query"""

    query_string = request.args.get("search-bar")
    # resp = requests.get(f'{BASE_URL_ED}/search?', params={'q':f'keto {query_string}',"app_id":APP_ID_RECIPE,"app_key":APP_KEY_RECIPE,"healt":'keto-friendly',"from":0,"to":20})
    # utilities.save_recipe_to_database(resp)
    rec = Recipe.query.filter(Recipe.title.ilike(f"%{query_string}%")).all()
    size = len(rec)
    recipes = in_util.partition_list(rec,3)
    n_carbs = in_util.partition_list(n_util.calculate_all_recipes_netcarbs(rec),3)
    return render_template('/recipes/recipe-result.html', recipes=recipes, size=size, n_carbs=n_carbs)

@app.route('/api/get-recipe-database/<int:id>', methods=['GET','POST'])
def get_recipe_database(id):
    """Return recipe Information--ingredients,nutritional data, directions etc"""

    recipe = Recipe.query.get(id)
    comment_form = CommentsForm()
    if not recipe:
        flash(f"Recipe Not Found...")
        return redirect('/')
    if comment_form.validate_on_submit() and CURR_USER_KEY in session:
        comment = Comment(comment=comment_form.comment.data,user_id=g.user.id,recipe_id=id)
        db.session.add(comment)
        db.session.commit()
        return redirect(f'/api/get-recipe-database/{id}')
    comments = recipe.comments
    users,times = u_util.get_users(recipe)
    avg_rate = r_util.calculate_average_rating(id,recipe.average_rate)
    user_rating = rec_util.is_empty_query(id)
    percentages = r_util.calculate_percentages_stars(id)
    nutrients,vitamins = rec_util.get_nutrients_recipe(recipe,recipe.servings)
    nutrients = n_util.sort_nutrients(nutrients)
    fats,carbs,no_daily = n_util.get_fats_carbs()
    calories = math.ceil(recipe.calories/recipe.servings)
    return render_template("/recipes/recipe-check.html", recipe=recipe, nutrients=nutrients, vitamins=vitamins,fats=fats,carbs=carbs,calories=calories,no_daily=no_daily, user_rating=user_rating, percentages=percentages,comment_form=comment_form,comments=comments, users=users,times=times)

########### User's Recipes #############################################

@app.route('/api/your-best-recipes')
@access.login_required
def get_best_rated():
    """Get all best rated recipes """

    best_rated, user_ratings, net_carbs = u_util.get_best_rated_recipes()
    best = in_util.partition_list(best_rated,3)
    u_rated = in_util.partition_list(user_ratings,3)
    n_carbs = in_util.partition_list(net_carbs,3)
    size = len(best_rated)
    return render_template('/recipes/best-rated-recipes.html',best_rated=best, user_ratings=u_rated,size=size,net_carbs=n_carbs)

@app.route('/api/my-recipes')
@access.login_required
def get_my_recipes():
    """Get all best rated recipes """

    my_recipes, net_carbs = rec_util.get_my_recipes()
    my_recipes = in_util.partition_list(my_recipes,3)
    net_carbs = in_util.partition_list(net_carbs,3)
    size = len(my_recipes)
    return render_template('/recipes/my-recipes.html',recipes=my_recipes, net_carbs=net_carbs,size=size)

@app.route('/api/add-rating', methods=["POST"])
@access.login_required
def add_ratings():
    """Add rating to the recipe only if logged in"""

    recipe_id = int(request.json['recipe_id'])
    rating = int(request.json['rating'])
    r_util.rate_recipe(recipe_id,rating)
    percentages = r_util.calculate_percentages_stars(recipe_id)
    avg_rate = r_util.calculate_average_rating(recipe_id,rating)
    return jsonify(avg_rate,percentages)

#### Need to work on this one just yet -- think can be a great functionality for extraction recipe from webpage and store it in database
@app.route('/api/get-instructions')
def get_instructions():
    """Extract Data From Website"""
    url = request.args.get('url')
    resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
    return jsonify(resp.json())


@app.route('/api/create-recipe')
@access.login_required
def get_create_recipe_form():
    """Create a new recipe and add it to the database"""

    form = TitleRecipeForm()

    if form.title.validate(form):
        title = form.title.data
    return render_template('/recipes/create-recipe.html',form=form)

@app.route('/api/create-recipe', methods=["POST"])
@access.login_required
def submit_recipe():
    """Create Recipe and Add it to database"""

    file = request.files.get('file')
    other_data = json.loads(request.form.get('otherData'))
    new_recipe = rec_util.handle_adding_recipe_data(other_data,file)
    return jsonify(f'/api/get-recipe-database/{new_recipe.id}')

@app.route('/api/delete-ingredient',methods=["POST"])
@access.login_required
def delete_ingredient_from_recipe():
    """Delete ingredient while creating recipe"""
    data = request.json.get('data')
    nutrients = json.loads(data.get('nutrients'))
    vitamins = json.loads(data.get('vitamins'))
    total_nutrients = json.loads(data.get('total_nutrients'))
    total_vitamins = json.loads(data.get('total_vitamins'))
    total_nutrients = n_util.subtract_nutrients(total_nutrients,nutrients)
    total_vitamins = n_util.subtract_nutrients(total_vitamins,vitamins)
    return jsonify(total_nutrients, total_vitamins)

@app.route('/images/<int:recipe_id>.png')
def get_image(recipe_id):
    """Get Blob image of the recipe from database and convert it into readable format for image TAG"""
    
    recipe = Recipe.query.get(recipe_id)
    image_binary = recipe.local_image
    return send_file(BytesIO(image_binary),as_attachment=False, attachment_filename=f'{recipe_id}.png')