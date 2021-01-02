"""File for other computations,querying, sorting and other app functionalities"""

import math, json
from models import db, Unit, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient, Product, User, Rating
import requests
from flask import g

# from app import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"


def calculate_net_carbs(recipe):
    """Calculate Net Carbs"""
    daily_nutrients = RecipeNutrient.query.filter((RecipeNutrient.nutrient_id == 51) | (RecipeNutrient.nutrient_id == 10) ,RecipeNutrient.recipe_id == recipe.id).first()
    return daily_nutrients.total_nutrients

def calculate_per_serving(nutrients,servings):
    """Compute Nutrients per serving"""

    for nutrient in nutrients:
        if nutrients[nutrient]["amount"]:
            nutrients[nutrient]["amount"] = math.ceil(nutrients[nutrient]["amount"]/servings)
        if nutrients[nutrient]["percentOfDailyNeeds"]:
            nutrients[nutrient]["percentOfDailyNeeds"] = math.ceil(nutrients[nutrient]["percentOfDailyNeeds"]/servings)
    return nutrients

def add_nutrients(nutrients_total,nutrients):
    """Calculate total amount of all nutrients of ingredients after adding the ingredient"""

    for nutrient in nutrients:
        if nutrient in nutrients_total:
            nutrients_total[nutrient]["amount"] += nutrients[nutrient]["amount"]
            nutrients_total[nutrient]["percentOfDailyNeeds"] += nutrients[nutrient]["percentOfDailyNeeds"]
        else:
            nutrients_total[nutrient] = nutrients[nutrient]

    return nutrients_total

def subtract_nutrients(nutrients_total,nutrients):
    """Calculate total of all nutrients of ingrerdients after deletion the ingredient"""
    for nutrient in nutrients:
        if nutrient in nutrients_total:
            nutrients_total[nutrient]["amount"] -= nutrients[nutrient]["amount"]
            nutrients_total[nutrient]["percentOfDailyNeeds"] -= nutrients[nutrient]["percentOfDailyNeeds"]

    return nutrients_total


def calculate_all_recipes_netcarbs(recipes):
    """Calculate netcarbs for all recipes"""
    for recipe in recipes:
        print(recipe.title)
        print(calculate_net_carbs(recipe))
        print(recipe.servings)
        print('--------------------------------')
    # import pdb
    # pdb.set_trace()
    return [int(round(calculate_net_carbs(recipe))) if recipe.user_id else int(round(calculate_net_carbs(recipe)/recipe.servings)) for recipe in recipes]

def get_carousel_card_info(recipes):
    """Get all information from carousel"""

    copy_recipe = recipes[:]
    netcarbs = calculate_all_recipes_netcarbs(recipes)
    return [(copy_recipe[i].title,copy_recipe[i].image,copy_recipe[i].servings,netcarbs[i],copy_recipe[i].id,copy_recipe[i].local_image) for i in range(len(netcarbs))]

def partition_list(lst,n):
    """Divide ingredients into grid for displaying on front page"""

    return [lst[i * n:(i + 1) * n] for i in range((len(lst) + (n-1)) // n )]

def split_nutritional_fact_data(nutrients):
    """spoonacular API data to save split/convert nutrients/vitamins"""

    flag = True
    nutri_data = dict()
    vitamins = dict()
    vit_set = set(['Calcium','Magnesium','Potassium','Zinc','Phosphorus'])
    for nutrient in nutrients:
        if nutrient["amount"] > 1:
            nutrient["amount"] = math.ceil(nutrient["amount"])
        if nutrient["percentOfDailyNeeds"] > 1:
            nutrient["percentOfDailyNeeds"] = math.ceil(nutrient["percentOfDailyNeeds"])
        if flag and nutrient["title"] not in vit_set and nutrient["title"].find("Vitamin") == -1:
            nutri_data[nutrient["title"]] = nutrient
        else:
            flag = False
            vitamins[nutrient["title"]] = nutrient
    return nutri_data,vitamins

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

def total_daily_nutrition(nutrient,recipe_obj,total,daily,label):
    """Add association to the many to many relationship RecipeNutrient"""

    nutri = Nutrient.query.filter_by(name=nutrient[label]).first()
    if nutri:
        association = RecipeNutrient(total_nutrients=int(nutrient.get(total)),total_daily=int(nutrient.get(daily)))
        association.nutrient_id = nutri.id
        recipe_obj.assignments.append(association)

def rate_recipe(recipe_id,rating):
    """Rate the recipe only for registered and athenticated users"""

    rated_query = Rating.query.filter((Rating.recipe_id == recipe_id) & (Rating.user_id==g.user.id)).first()
    if rated_query:
        rated_query.rating = rating
    else:
        rating = Rating(recipe_id=recipe_id,user_id=g.user.id,rating=rating)
        db.session.add(rating)
    db.session.commit()
    
def calculate_average_rating(recipe_id,rating):
    """Calculate average rating of recipe and add it to the database"""

    recipe = Recipe.query.get(recipe_id)
    if recipe.ratings:
        ratings = [r.rating for r in recipe.ratings]
        recipe.average_rate = round(sum(ratings)/len(ratings),1)
    else:
        recipe.average_rate = rating
    db.session.commit()
    return recipe.average_rate

def get_best_rated_recipes():
    """Get best rated recipes by the user"""

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

    return best_rated,user_ratings,net_carbs

def get_my_recipes():
    """Get Recipes created by a user"""
    user = User.query.get(g.user.id)
    net_carbs = []
    for recipe in user.recipes:
        res = calculate_all_recipes_netcarbs([recipe])
        net_carbs.append(res[0])

    return user.recipes,net_carbs

def is_empty_query(id):
    """Get rating if exists otherwise return 0"""

    if g.user:
        rated_query = Rating.query.filter((Rating.recipe_id == id) & (Rating.user_id==g.user.id)).first()
        return rated_query.rating if rated_query else 0
    else:
        return 0

def calculate_percentages_stars(id):
    """Calculate the percent of the stars per recipe"""

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

def add_relationships_to_recipe(recipe_obj,instructions,ingredients,nutrients):
    """Append relationships: instructions,ingreedients, nutrients to object recipe"""

    for i, inst in enumerate(instructions):
        instruction = Instruction(step_no=i+1, step=inst['step'])
        recipe_obj.instructions.append(instruction)

    for ingr in ingredients:
        ingredient = Ingredient(name=ingr.get("text"), image=ingr.get("image"))
        recipe_obj.ingredients.append(ingredient)

    for nutrient in nutrients:
        total_daily_nutrition(nutrient,recipe_obj,'total','daily','label')
        if nutrient.get("sub"):
            for subnutrient in nutrient.get("sub"):
                total_daily_nutrition(subnutrient,recipe_obj,'total','daily','label')


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
        total_daily_nutrition(nutrients[nutrient],new_recipe,'amount','percentOfDailyNeeds','title')

    db.session.add(new_recipe)
    db.session.commit()

    return new_recipe

def get_fats_carbs():
    """Get objects fats, carbs and nutrients that do not have daily amounts"""

    fats = tuple(["Trans Fat","Trans","Saturated Fat","Saturated","Polyunsaturated","Poly Unsaturated Fat","Mono Unsaturated Fat","Monounsaturated"])
    carbs = tuple(["Net Carbohydrates","Carbs (net)","Fiber","Sugar Alcohol",'Sugar alcohols',"Sugar","Sugars",'Sugars, added'])
    no_daily = tuple(["Sugar","Sugars",'Sugars, added','Protein','Monounsaturated','Polyunsaturated'])
    return fats,carbs,no_daily

def sort_nutrients(nutrients):
    """Sort our nutrients for Nutrition Table"""

    fats,carbs,no_daily = get_fats_carbs()
    sorted_nutrients = {}
    if nutrients.get("Carbs"):
        sorted_nutrients["Carbs"] = nutrients.pop("Carbs")
    if nutrients.get("Carbohydrates"):
        sorted_nutrients["Carbohydrates"] = nutrients.pop("Carbohydrates")
    for carb in carbs:
        if carb in nutrients:
            sorted_nutrients[carb] = nutrients.pop(carb)
    if nutrients.get("Fat"):
        sorted_nutrients["Fat"] = nutrients.pop("Fat")     
    for fat in fats:
        if fat in nutrients:
            sorted_nutrients[fat] = nutrients.pop(fat)
    
    sorted_nutrients.update(nutrients)
    return sorted_nutrients


def get_users(recipe):
    """Get all users and times for comments"""

    all_comments = recipe.comments
    users = []
    times = []
    for comment in all_comments:
        user = User.query.get(comment.user_id)
        users.append(user)
        times.append(comment.created_at)
    
    return users,times

