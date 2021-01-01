from app import app
from models import db, Unit, Recipe, Ingredient, Instruction, Nutrient, RecipeNutrient, Product, Rating
from secrets import APP_KEY, APP_ID_RECIPE, APP_KEY_RECIPE
import requests

# # db.drop_all()
# # db.create_all()

# # Script to load data

BASE_URL_SP = "https://api.spoonacular.com"
BASE_URL_ED = "https://api.edamam.com"

import json
id = 9040
resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY})

json_file = resp.json()

# mapping = json.dumps(json_file)
# rec = json.loads(mapping) 

# for rec_num in rec["hits"]:
#     # Recipe 1
#     recipe = rec_num['recipe']
#     # //////////////////////////////////
#     title = recipe['label']
#     if bool(db.session.query(Recipe).filter_by(title=title).first()):
#         print("SORRY it's already in database...")
#         continue
#     image = recipe['image']
#     servings = recipe['yield']
#     tcook = recipe['totalTime']
#     source = recipe['source']
#     url = recipe['url']
#     ingredients = recipe['ingredients']
#     calories = recipe['calories']
#     nutrients = recipe['digest']

#     instr_resp = requests.get(f'{BASE_URL_SP}/recipes/extract?', params={"apiKey":APP_KEY,"url":url})
#     json_file1 = instr_resp.json()
#     mapping1 = json.dumps(json_file1)
#     rec1 = json.loads(mapping1)
#     instrs = rec1["analyzedInstructions"][0]["steps"]

#     recipe_obj = Recipe(title=title, image=image, servings=servings,tcook=tcook, source=source, url=url,calories=calories)

#     for i, inst in enumerate(instrs):
#         instruction = Instruction(step_no=i+1, step=inst['step'])
#         recipe_obj.instructions.append(instruction)

#     for ingr in ingredients:
#         ingredient = Ingredient(name=ingr["text"], image=ingr["image"])
#         recipe_obj.ingredients.append(ingredient)

#     for key in total_nutri_keys:
#         if key in total_daily:
#             nutrient = Nutrient.query.filter_by(name=total_daily[key]["label"]).first()
#             if nutrient:
#                 association = RecipeNutrient(total_daily=int(total_daily[key]["quantity"]),total_nutrients=int(total_nutrients[key]["quantity"]))
#                 association.nutrient_id = nutrient.id
#                 recipe_obj.assignments.append(association)

#     db.session.add(recipe_obj)
#     print('Successfully Added!!!')
# db.session.commit()
# # keto_veggies = ['beets','red onion','carrots','artichoke']
# # for veggie in keto_veggies:
# #     resp = requests.get(f"{BASE_URL_SP}/food/ingredients/search?", params={"apiKey":APP_KEY,"query":veggie})    
# #     res = resp.json()
# #     veg_id = res['results'][0]["id"]
# #     name = res['results'][0]["name"]
# #     img = res['results'][0]["image"]
# #     img = f"https://spoonacular.com/cdn/ingredients_100x100/{img}"

# #     resp1 = requests.get(f'{BASE_URL_SP}/food/ingredients/{veg_id}/information', params={"apiKey":APP_KEY,"amount":"100","unit":"g"})
# #     res1 = resp1.json()
# #     import pdb
# #     pdb.set_trace()
# #     net_carbs = res1['nutrition']['nutrients'][4]['amount']
# #     product = Product(name=name,image=img,net_carbs=net_carbs)
# #     db.session.add(product)
# #     db.session.commit()

