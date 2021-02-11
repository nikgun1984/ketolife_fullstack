from models import db
import datetime

class Comment(db.Model):
    """User's comments table"""

    __tablename__ = 'comments'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    comment = db.Column(
        db.Text,
        nullable=False
    )

    user_id = db.Column(
        db.Integer, 
        db.ForeignKey('users.id')
    )

    recipe_id = db.Column(
        db.Integer, 
        db.ForeignKey('recipes.id')
    )

    created_at = db.Column(
        db.DateTime,
        default = datetime.datetime.utcnow
    )

    users = db.relationship('User', backref="comment")