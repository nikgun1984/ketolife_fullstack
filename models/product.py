from models import db

class Product(db.Model):
    """Product table for Home Page products"""

    __tablename__ = 'products'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    image = db.Column(
        db.Text
    )

    net_carbs = db.Column(
        db.Float
    )

    product_type = db.Column(
        db.Text
    )