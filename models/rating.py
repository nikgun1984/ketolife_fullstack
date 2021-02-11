from models import db

class Rating(db.Model):
    """Rating table Association table"""

    __tablename__ = 'ratings'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    user_id = db.Column(
        db.Integer,
        db.ForeignKey("users.id")
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey("recipes.id"),
        nullable=False
    )

    rating = db.Column(
        db.Integer,
        nullable=False
    )

    users = db.relationship('User', backref='rating')