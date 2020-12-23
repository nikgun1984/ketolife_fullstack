import math, json
# from app import app
from models import db, Unit, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient, Product
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
import requests

BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"


def calculate_net_carbs(recipe):
    """Calculate Net Carbs"""
    fiber = [nutrient.total_nutrients for nutrient in recipe.assignments if nutrient.nutrient_id == 11]
    res = None
    for nutrient in recipe.assignments:
        if nutrient.nutrient_id == 10:
            res = nutrient.total_nutrients
        elif nutrient.nutrient_id == 9:
            res = nutrient.total_nutrients - fiber[0]
        elif nutrient.nutrient_id == 40:
            res = nutrient.total_nutrients - fiber[0]
    return res

def calculate_all_recipes_netcarbs(recipes):
    """Calculate Net Carbs for recipe"""
    # import pdb
    # pdb.set_trace()
    return [calculate_net_carbs(recipe) for recipe in recipes]

def get_carousel_card_info(recipes):
    """Get all information from carousel"""
    copy_recipe = recipes[:]
    netcarbs = calculate_all_recipes_netcarbs(recipes)
    return [(copy_recipe[i].title,copy_recipe[i].image,copy_recipe[i].servings,int(netcarbs[i]/copy_recipe[i].servings),copy_recipe[i].id) for i in range(len(netcarbs))]

def partition_list(lst,n):
    """Divide ingredients into grid for displayong on front page"""
    return [lst[i * n:(i + 1) * n] for i in range((len(lst) + (n-1)) // n )]

def split_nutritional_fact_data(nutrients):
    """spoonacular API data to save split/convert nutrients/vitamins"""
    flag = True
    nutri_data = []
    vitamins = []
    for nutrient in nutrients:
        if nutrient["amount"] > 1:
            nutrient["amount"] = math.ceil(nutrient["amount"])
        if nutrient["percentOfDailyNeeds"] > 1:
            nutrient["percentOfDailyNeeds"] = math.ceil(nutrient["percentOfDailyNeeds"])
        if flag and nutrient["title"].find("Vitamin") == -1:
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
    for el in range(len(recipe.nutrients)):
        name = recipe.nutrients[el].name
        total_daily = math.ceil(recipe.assignments[el].total_daily/servings)
        total_nutrients = math.ceil(recipe.assignments[el].total_nutrients/servings)
        unit = recipe.nutrients[el].units.name
        if flag and name.find("Vitamin") == -1:
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

    for rec_num in rec["hits"]:
        # Recipe 1
        recipe = rec_num['recipe']
        # //////////////////////////////////
        title = recipe['label']
        #already exists in database skip it
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
        total_nutrients = recipe['totalNutrients']
        total_daily = recipe['totalDaily']

        instr_resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
        json_file1 = instr_resp.json()
        mapping1 = json.dumps(json_file1)
        rec1 = json.loads(mapping1)
        if not rec1["analyzedInstructions"][0]["steps"]:
            continue
        instrs = rec1["analyzedInstructions"][0]["steps"]

        recipe_obj = Recipe(title=title, image=image, servings=servings,tcook=tcook, source=source, url=url,calories=calories)

        for i, inst in enumerate(instrs):
            instruction = Instruction(step_no=i+1, step=inst['step'])
            recipe_obj.instructions.append(instruction)

        for ingr in ingredients:
            ingredient = Ingredient(name=ingr["text"], image=ingr["image"])
            recipe_obj.ingredients.append(ingredient)

        total_nutri_keys = list(total_nutrients.keys())

        for key in total_nutri_keys:
            if key in total_daily:
                nutrient = Nutrient.query.filter_by(name=total_daily[key]["label"]).first()
                if nutrient:
                    association = RecipeNutrient(total_daily=int(total_daily[key]["quantity"]),total_nutrients=int(total_nutrients[key]["quantity"]))
                    association.nutrient_id = nutrient.id
                    recipe_obj.assignments.append(association)

        db.session.add(recipe_obj)
        db.session.commit()
        print('Successfully Added!!!')



        


