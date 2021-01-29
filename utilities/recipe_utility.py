# imports
import json
import requests
from flask import g
##########################
from models import db, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient, User, Rating
from utilities import nutrient_utility as util
from settings import BASE_URL_SP,APP_KEY
##########################################

def get_carousel_card_info(recipes):
    """Get all information from carousel"""

    copy_recipe = recipes[:]
    netcarbs = util.calculate_all_recipes_netcarbs(recipes)
    return [(copy_recipe[i].title,copy_recipe[i].image,copy_recipe[i].servings,netcarbs[i],copy_recipe[i].id,copy_recipe[i].local_image) for i in range(len(netcarbs))]

def add_relationships_to_recipe(recipe_obj,instructions,ingredients,nutrients):
    """Append relationships: instructions,ingreedients, nutrients to object recipe"""

    for i, inst in enumerate(instructions):
        instruction = Instruction(step_no=i+1, step=inst['step'])
        recipe_obj.instructions.append(instruction)

    for ingr in ingredients:
        ingredient = Ingredient(name=ingr.get("text"), image=ingr.get("image"))
        recipe_obj.ingredients.append(ingredient)

    for nutrient in nutrients:
        util.total_daily_nutrition(nutrient,recipe_obj,'total','daily','label')
        if nutrient.get("sub"):
            for subnutrient in nutrient.get("sub"):
                util.total_daily_nutrition(subnutrient,recipe_obj,'total','daily','label')

def handle_adding_recipe_data(data,local_image):
    """Add all data firstly to a newly created recipe then recipe to the database"""

    title = data['title']
    servings = data['servings']
    ingredients = data['ingredients']
    instructions = data['instructions']
    nutrients = data['total_nutrients']
    vitamins = data['total_vitamins']
    calories = nutrients['Calories']['amount']
    nutrients.pop('Calories', None)
    nutrients.update(vitamins)
    tcook = data['ttime']
    mealtype = data['mealType']
    dishtype = data['dishType']

    new_recipe = Recipe(title=title, servings=servings,tcook=tcook, calories=calories,mealtype=mealtype,dishtype=dishtype,local_image=local_image.read(), user_id=g.user.id)

    for i, inst in enumerate(instructions):
        instruction = Instruction(step_no=i+1, step=inst)
        new_recipe.instructions.append(instruction)

    for ingr in ingredients:
        ingredient = Ingredient(name=ingr)
        new_recipe.ingredients.append(ingredient)

    for nutrient in nutrients:
        util.total_daily_nutrition(nutrients[nutrient],new_recipe,'amount','percentOfDailyNeeds','title')

    db.session.add(new_recipe)
    db.session.commit()

    return new_recipe

def save_recipe_to_database(resp):
    """Will save recipe to database"""

    json_file = resp.json()

    mapping = json.dumps(json_file)
    rec = json.loads(mapping) 

    if not rec.get("hits"):
        return

    for rec_num in rec["hits"]:

        recipe = rec_num['recipe']
        title = recipe['label']
        if bool(db.session.query(Recipe).filter_by(title=title).first()):
            print("SORRY it's already in database...")
            continue
        image = recipe['image']
        servings = recipe['yield']
        tcook = recipe['totalTime']
        source = recipe['source']
        url = recipe['url']
        ingredients = recipe['ingredients']
        calories = recipe['calories']
        nutrients = recipe['digest']

        instr_resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
        json_file1 = instr_resp.json()
        mapping1 = json.dumps(json_file1)
        rec1 = json.loads(mapping1)
        if not rec1.get("analyzedInstructions"):
            continue
        instrs = rec1["analyzedInstructions"][0]["steps"]

        recipe_obj = Recipe(title=title, image=image, servings=servings,tcook=tcook, source=source, url=url,calories=calories)

        add_relationships_to_recipe(recipe_obj,instrs,ingredients,nutrients)

        db.session.add(recipe_obj)
        print('Successfully Added!!!')
    db.session.commit()

def get_nutrients_recipe(recipe,servings):
    """Using database to save split/convert nutrients/vitamins"""

    flag = True
    nutri_data = dict()
    vitamins = dict()
    vit_set = set(['Calcium','Magnesium','Potassium','Zinc','Phosphorus'])
    for el in range(len(recipe.nutrients)):
        name = recipe.nutrients[el].name
        if recipe.user_id:
            total_daily = int(round(recipe.assignments[el].total_daily,0))
            total_nutrients = int(round(recipe.assignments[el].total_nutrients,0))
        else:
            total_daily = int(round(recipe.assignments[el].total_daily/servings,0))
            total_nutrients = int(round(recipe.assignments[el].total_nutrients/servings,0))
        unit = recipe.nutrients[el].units.name
        if flag and name not in vit_set and name.find("Vitamin") == -1:
            nutri_data[name] = name,total_daily,total_nutrients,unit
        else:
            flag = False
            vitamins[name] = name,total_daily,total_nutrients,unit
    return nutri_data,vitamins

def get_my_recipes():
    """Get Recipes created by a user"""
    user = User.query.get(g.user.id)
    net_carbs = []
    for recipe in user.recipes:
        res = util.calculate_all_recipes_netcarbs([recipe])
        net_carbs.append(res[0])

    return user.recipes,net_carbs

def is_empty_query(id):
    """Get rating if exists otherwise return 0"""

    if g.user:
        rated_query = Rating.query.filter((Rating.recipe_id == id) & (Rating.user_id==g.user.id)).first()
        return rated_query.rating if rated_query else 0
    else:
        return 0
