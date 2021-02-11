from models import db

class Instruction(db.Model):
    """Instructions Model"""

    __tablename__ = 'instructions'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    step_no = db.Column(
        db.Integer,
        nullable=False
    )

    step = db.Column(
        db.Text,
        nullable=False
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey('recipes.id'))