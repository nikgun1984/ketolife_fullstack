import math, json
# from app import app
from models import db, Unit, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient, Product, User, Rating
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
import requests
from flask import g

BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"


def calculate_net_carbs(recipe):
    """Calculate Net Carbs"""
    daily_nutrients = RecipeNutrient.query.filter(RecipeNutrient.nutrient_id == 51,RecipeNutrient.recipe_id == recipe.id).one()
    # fiber = [nutrient.total_nutrients for nutrient in recipe.assignments if nutrient.nutrient_id == 11]
    # for nutrient in recipe.assignments:
    #     if nutrient.nutrient_id == 10:
    #         res = nutrient.total_nutrients
    #     elif nutrient.nutrient_id == 9:
    #         res = nutrient.total_nutrients - fiber[0]
    #     elif nutrient.nutrient_id == 40:
    #         res = nutrient.total_nutrients - fiber[0]
    return daily_nutrients.total_nutrients

def calculate_all_recipes_netcarbs(recipes):
    """Calculate Net Carbs for recipe"""
    # import pdb
    # pdb.set_trace()
    return [int(calculate_net_carbs(recipe)/recipe.servings) for recipe in recipes]

def get_carousel_card_info(recipes):
    """Get all information from carousel"""
    copy_recipe = recipes[:]
    netcarbs = calculate_all_recipes_netcarbs(recipes)
    return [(copy_recipe[i].title,copy_recipe[i].image,copy_recipe[i].servings,netcarbs[i],copy_recipe[i].id) for i in range(len(netcarbs))]

def partition_list(lst,n):
    """Divide ingredients into grid for displayong on front page"""
    return [lst[i * n:(i + 1) * n] for i in range((len(lst) + (n-1)) // n )]

def split_nutritional_fact_data(nutrients):
    """spoonacular API data to save split/convert nutrients/vitamins"""
    flag = True
    nutri_data = []
    vitamins = []
    vit_set = set(['Calcium','Magnesium','Potassium','Zinc','Phosphorus'])
    for nutrient in nutrients:
        if nutrient["amount"] > 1:
            nutrient["amount"] = math.ceil(nutrient["amount"])
        if nutrient["percentOfDailyNeeds"] > 1:
            nutrient["percentOfDailyNeeds"] = math.ceil(nutrient["percentOfDailyNeeds"])
        if flag and nutrient["title"] not in vit_set and nutrient["title"].find("Vitamin") == -1:
            nutri_data.append(nutrient)
        else:
            flag = False
            vitamins.append(nutrient)
    return nutri_data,vitamins


def get_nutrients_recipe(recipe,servings):
    """Using database to save split/convert nutrients/vitamins"""
    flag = True
    nutri_data = []
    vitamins = []
    vit_set = set(['Calcium','Magnesium','Potassium','Zinc','Phosphorus'])
    for el in range(len(recipe.nutrients)):
        name = recipe.nutrients[el].name
        total_daily = math.ceil(recipe.assignments[el].total_daily/servings)
        total_nutrients = math.ceil(recipe.assignments[el].total_nutrients/servings)
        unit = recipe.nutrients[el].units.name
        if flag and name not in vit_set and name.find("Vitamin") == -1:
            nutri_data.append((name,total_daily,total_nutrients,unit))
        else:
            flag = False
            vitamins.append((name,total_daily,total_nutrients,unit))
    return nutri_data,vitamins

def save_recipe_to_database(resp):
    """Will save recipe to database"""
    json_file = resp.json()

    mapping = json.dumps(json_file)
    rec = json.loads(mapping) 

    if not rec.get("hits"):
        return

    for rec_num in rec["hits"]:
    # Recipe 1
        recipe = rec_num['recipe']
        # //////////////////////////////////
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

        for i, inst in enumerate(instrs):
            instruction = Instruction(step_no=i+1, step=inst['step'])
            recipe_obj.instructions.append(instruction)

        for ingr in ingredients:
            ingredient = Ingredient(name=ingr["text"], image=ingr["image"])
            recipe_obj.ingredients.append(ingredient)

        for nutrient in nutrients:
            total_daily_nutrition(nutrient,recipe_obj)
            if nutrient.get("sub"):
                for subnutrient in nutrient.get("sub"):
                    total_daily_nutrition(subnutrient,recipe_obj)

        db.session.add(recipe_obj)
        print('Successfully Added!!!')
    db.session.commit()

def total_daily_nutrition(nutrient,recipe_obj):
    nutri = Nutrient.query.filter_by(name=nutrient["label"]).first()
    if nutri:
        association = RecipeNutrient(total_nutrients=int(nutrient.get("total")),total_daily=int(nutrient.get("daily")))
        association.nutrient_id = nutri.id
        recipe_obj.assignments.append(association)

def is_already_rated(recipe_id,rating):
    rated_query = Rating.query.filter((Rating.recipe_id == recipe_id) & (Rating.user_id==g.user.id)).first()
    if rated_query:
        rated_query.rating = rating
    else:
        rating = Rating(recipe_id=recipe_id,user_id=g.user.id,rating=rating)
        db.session.add(rating)
    db.session.commit()
    

def calculate_average_rating(recipe_id,rating):
    recipe = Recipe.query.get(recipe_id)
    if recipe.ratings:
        ratings = [r.rating for r in recipe.ratings]
        recipe.average_rate = round(sum(ratings)/len(ratings),1)
    else:
        recipe.average_rate = rating
    db.session.commit()
    return recipe.average_rate

def get_best_rated_recipes():
    user = User.query.get(g.user.id)
    rated_recipes = user.rating
    best_rated = []
    user_ratings = []
    net_carbs = []
    for rated in rated_recipes:
    
        if rated.rating >= 4:
            recipe = Recipe.query.get(rated.recipe_id)
            res = calculate_all_recipes_netcarbs([recipe])
            best_rated.append(recipe)
            user_ratings.append(rated.rating)
            net_carbs.append(res[0])
    # import pdb
    # pdb.set_trace()
    return best_rated,user_ratings,net_carbs

def is_empty_query(id):
    rated_query = Rating.query.filter((Rating.recipe_id == id) & (Rating.user_id==g.user.id)).first()
    return rated_query.rating if rated_query else 0


def calculate_percentages_stars(id):

    recipe = Recipe.query.get(id)
    if recipe.ratings:
        all_ratings = [[] for i in range(5)]
        for rating in recipe.ratings:
            if rating.rating == 1:
                all_ratings[0].append(rating.rating)
            elif rating.rating == 2:
                all_ratings[1].append(rating.rating)
            elif rating.rating == 3:
                all_ratings[2].append(rating.rating)
            elif rating.rating == 4:
                all_ratings[3].append(rating.rating)
            else:
                all_ratings[4].append(rating.rating)

        total = sum(len(pair) for pair in all_ratings)
        percentages = [math.floor((len(row)/total)*100) for row in all_ratings]
        return percentages
    return None




        


