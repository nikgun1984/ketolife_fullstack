from app import app
from models import db, Unit

db.drop_all()
db.create_all()

u1 = Unit(
    name = 'ounce',
    abbr = 'oz'
)

u2 = Unit(
    name = 'gram',
    abbr = 'g'
)

u3 = Unit(
    name = 'pound',
    abbr = 'lb'
)

u4 = Unit(
    name = 'kilogram',
    abbr = 'kg'
)

u5 = Unit(
    name = 'pinch',
    abbr = 'pinch'
)
u6 = Unit(
    name = 'milliliter',
    abbr = 'ml'
)
u7 = Unit(
    name = 'liter',
    abbr = 'l'
)
u8 = Unit(
    name = 'fluid ounce',
    abbr = 'fl oz'
)
u9 = Unit(
    name = 'quart',
    abbr = 'qt'
)

u11 = Unit(
    name = 'gallon',
    abbr = 'gal'
)
u12 = Unit(
    name = 'pint',
    abbr = 'pt'
)
u13 = Unit(
    name = 'drop',
    abbr = 'drop'
)

u14 = Unit(
    name = 'cup',
    abbr = 'cup'
)

u15 = Unit(
    name = 'tablespoon',
    abbr = 'tbsp'
)

u16 = Unit(
    name = 'teaspoon',
    abbr = 'tsp'
)

db.session.add_all([u1,u2,u3,u4,u5,u6,u7,u8,u9,u11,u12,u13,u14,u15,u16])
db.session.commit()







