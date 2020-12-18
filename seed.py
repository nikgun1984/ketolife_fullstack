from app import app
from models import db, Unit, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
import requests

# # db.drop_all()
# # db.create_all()

# # Script to load data

# BASE_URL_SP = "https://api.spoonacular.com"
# BASE_URL_ED = "https://api.edamam.com"

# import json

# resp = requests.get(f'{BASE_URL_ED}/search?', params={'q':f'keto',"app_id":APP_ID_RECIPE,"app_key":APP_KEY_RECIPE,"healt":'keto-friendly'})

# json_file = resp.json()

# mapping = json.dumps(json_file)
# rec = json.loads(mapping) 

# for rec_num in rec["hits"]:
#     # Recipe 1
#     recipe = rec_num['recipe']
#     # //////////////////////////////////
#     title = recipe['label']
#     image = recipe['image']
#     servings = recipe['yield']
#     tcook = recipe['totalTime']
#     source = recipe['source']
#     url = recipe['url']
#     ingredients = recipe['ingredients']
#     calories = recipe['calories']
#     total_nutrients = recipe['totalNutrients']
#     total_daily = recipe['totalDaily']

#     instr_resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
#     json_file1 = instr_resp.json()
#     mapping1 = json.dumps(json_file1)
#     rec1 = json.loads(mapping1)
#     instrs = rec1["analyzedInstructions"][0]["steps"]

#     recipe_obj = Recipe(title=title, image=image, servings=servings,tcook=tcook, source=source, url=url)

#     for i, inst in enumerate(instrs):
#         instruction = Instruction(step_no=i+1, step=inst['step'])
#         recipe_obj.instructions.append(instruction)

#     for ingr in ingredients:
#         ingredient = Ingredient(name=ingr["text"], image=ingr["image"])
#         recipe_obj.ingredients.append(ingredient)

#     total_nutri_keys = list(total_nutrients.keys())

#     for key in total_nutri_keys:
#         if key in total_daily:
#             nutrient = Nutrient.query.filter_by(name=total_daily[key]["label"]).first()
#             if nutrient:
#                 association = RecipeNutrient(total_daily=int(total_daily[key]["quantity"]),total_nutrients=int(total_nutrients[key]["quantity"]))
#                 association.nutrient_id = nutrient.id
#                 recipe_obj.assignments.append(association)

#     db.session.add(recipe_obj)
# db.session.commit()

