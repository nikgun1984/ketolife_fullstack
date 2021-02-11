from models import db

class Unit(db.Model):
    """Unit Model"""

    __tablename__ = 'units'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        unique=True,
        nullable=False
    )