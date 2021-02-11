from models import db

class Ingredient(db.Model):
    """Ingredient Model"""

    __tablename__ = 'ingredients'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        nullable=False
    )

    image = db.Column(
        db.Text,
        default="/static/images/ing.png"
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey('recipes.id'))