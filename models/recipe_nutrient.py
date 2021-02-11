from models import db

class RecipeNutrient(db.Model):
    """Recipe-Nutrient Model Association table"""

    __tablename__ = 'recipe_has_nutrients'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey("recipes.id"),
        nullable=False
    )

    nutrient_id = db.Column(
        db.Integer,
        db.ForeignKey("nutrients.id"),
        nullable=False
    )

    total_daily = db.Column(
        db.Integer,
        nullable=False
    )

    total_nutrients = db.Column(
        db.Integer,
        nullable=False
    )