from models import db

class Nutrient(db.Model):
    """Nutrients Model"""

    __tablename__ = 'nutrients'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        nullable=False
    )

    unit_id = db.Column(
        db.Integer,
        db.ForeignKey('units.id'),
        nullable = True
    )

    daily_value = db.Column(
        db.Integer    
    )

    units = db.relationship('Unit', backref='nutrient')