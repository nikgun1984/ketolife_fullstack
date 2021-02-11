################# Flask and SQLAlchemy
from flask import render_template, request, jsonify
################# Other libraries
import requests
################# Imported from external files
from app import app
from settings import BASE_URL_SP,BASE_IMG_LINK, APP_KEY
from utilities import nutrient_utility as util

@app.route("/api/get-ingredient")
def get_ingredient_id():
    """Need to get ingredient ID in order to access all attributes"""

    query = request.args["text"]
    resp = requests.get(f"{BASE_URL_SP}/food/ingredients/search?", params={"apiKey":APP_KEY,"query":query})
    res = resp.json()
    lst = {res['results'][i]["name"]:res['results'][i]["id"] for i in range(len(res['results']))}
    return jsonify(lst)

@app.route("/api/get-ingredient/<id>")
def get_ingredient_info(id):
    """Resp: name, units, category"""

    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY})
    res = resp.json()
    lst = [unit for unit in res['possibleUnits']]
    category = res['categoryPath']
    return jsonify(units=lst,img=res['image'],name=res['name'],id=id,category=category)

@app.route("/api/get-ingredient/<id>/info")
def ingredient_nutrifacts(id):
    """Nutritional Data of an ingredient"""

    unit = request.args.get('units')
    amount = request.args.get('amount')
    resp = requests.get(f'{BASE_URL_SP}/food/ingredients/{id}/information', params={"apiKey":APP_KEY,"amount":amount,"unit":unit})
    res = resp.json()
    name = res["name"].capitalize()
    img = f"{BASE_IMG_LINK}/{res['image']}"
    category = res["categoryPath"]
    cost = round(res['estimatedCost']['value']/100,3)
    nutrients,vitamins = util.split_nutritional_fact_data(res['nutrition']['nutrients'])
    calories = nutrients.pop('Calories')
    fats,carbs,no_daily = util.get_fats_carbs()
    unit = res['unit']

    return render_template("/ingredients/ingredient-info.html", name=name,cost=cost,nutrients=nutrients,vitamins=vitamins,unit=unit, amount=amount,carbs=carbs,fats=fats,no_daily=no_daily,img=img,category=category,nutri = list(nutrients),vit=list(vitamins), calories=calories)
