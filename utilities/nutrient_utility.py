import math
from models import Nutrient, RecipeNutrient

def total_daily_nutrition(nutrient,recipe_obj,total,daily,label):
    """Add association to the many to many relationship RecipeNutrient"""

    nutri = Nutrient.query.filter_by(name=nutrient[label]).first()
    if nutri:
        association = RecipeNutrient(total_nutrients=int(nutrient.get(total)),total_daily=int(nutrient.get(daily)))
        association.nutrient_id = nutri.id
        recipe_obj.assignments.append(association)

def add_nutrients(nutrients_total,nutrients):
    """Calculate total amount of all nutrients of ingredients after adding the ingredient"""

    for nutrient in nutrients:
        if nutrient in nutrients_total:
            nutrients_total[nutrient]["amount"] += nutrients[nutrient]["amount"]
            nutrients_total[nutrient]["percentOfDailyNeeds"] += nutrients[nutrient]["percentOfDailyNeeds"]
        else:
            nutrients_total[nutrient] = nutrients[nutrient]

    return nutrients_total

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

def calculate_percent_daily_needs(amount, nutrient_name):
    query_data = Nutrient.query.filter((Nutrient.daily_value == nutrient_name))
    return int((amount/query_data.daily_value)*100) if query_data else None 


def subtract_nutrients(nutrients_total,nutrients):
    """Calculate total of all nutrients of ingrerdients after deletion the ingredient"""
    for nutrient in nutrients:
        if nutrient in nutrients_total:
            nutrients_total[nutrient]["amount"] -= nutrients[nutrient]["amount"]
            nutrients_total[nutrient]["percentOfDailyNeeds"] -= nutrients[nutrient]["percentOfDailyNeeds"]

    return nutrients_total


def calculate_all_recipes_netcarbs(recipes):
    """Calculate netcarbs for all recipes"""
    return [int(round(calculate_net_carbs(recipe))) if recipe.user_id else int(round(calculate_net_carbs(recipe)/recipe.servings)) for recipe in recipes]

def split_nutritional_fact_data(nutrients):
    """spoonacular API data to save split/convert nutrients/vitamins"""

    nutri_data = dict()
    vitamins = dict()
    nutri_set = set(['Calories','Fat','Trans Fat','Saturated fat','Mono Saturated Fat', 'Protein','Cholesterol','Carbohydrates','Fiber','Sugar'])
    for idx,nutrient in enumerate(nutrients):
        if nutrient["amount"] > 1:
            nutrient["amount"] = math.ceil(nutrient["amount"])
        if nutrient.get("percentOfDailyNeeds") and nutrient["percentOfDailyNeeds"] > 1:
            nutrient["percentOfDailyNeeds"] = math.ceil(nutrient["percentOfDailyNeeds"])
        if nutrient["title"] in nutri_set:
            nutri_data[nutrient["title"]] = nutrients.pop(idx)
        else:
            vitamins[nutrient["title"]] = nutrients.pop(idx)
    return nutri_data,vitamins

def total_daily_nutrition(nutrient,recipe_obj,total,daily,label):
    """Add association to the many to many relationship RecipeNutrient"""

    nutri = Nutrient.query.filter_by(name=nutrient[label]).first()
    if nutri:
        association = RecipeNutrient(total_nutrients=int(nutrient.get(total)),total_daily=int(nutrient.get(daily)))
        association.nutrient_id = nutri.id
        recipe_obj.assignments.append(association)

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
