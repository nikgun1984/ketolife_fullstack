from models import User, Recipe
from flask import g
from utilities import nutrient_utility as util

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
            res = util.calculate_all_recipes_netcarbs([recipe])
            best_rated.append(recipe)
            user_ratings.append(rated.rating)
            net_carbs.append(res[0])

    return best_rated,user_ratings,net_carbs