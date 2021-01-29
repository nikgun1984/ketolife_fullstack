import math
from models import db, Recipe, User, Rating
from flask import g

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