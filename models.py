from flask_bcrypt import Bcrypt
from flask_sqlalchemy import SQLAlchemy

bcrypt = Bcrypt()
db = SQLAlchemy()

class Recipe(db.Model):

    __tablename__ = 'recipes'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    title = db.Column(
        db.Text,
        nullable=False

    )

    image = db.Column(
        db.Text,
        default="/static/images/default-recipe.png"
    )

    no_serv = db.Column(
        db.Integer
    )

    tprep = db.Column(
        db.Integer
    )

    tcook = db.Column(
        db.Integer
    )

    cuisine = db.Column(
        db.Text
    )

    mealtype = db.Column(
        db.Text
    )

    dishtype = db.Column(
        db.Text
    )

    instructions = db.relationship('Instruction',backref=db.backref("recipes"), cascade="all,delete")

    def serialize(self):
        """Serialize our object recipe to dictionary for json"""
        return {
            "id": self.id,
            "title": self.title,
            "image": self.image,
            "servings": self.no_serv,
            "image": self.image,
            "tprep": self.tprep,
            "tcook": self.tcook,
            "cuisine": self.cuisine,
            "mealtype": self.mealtype,
            "dishtype": self.dishtype
        }

class Ingredient(db.Model):

    __tablename__ = 'ingredients'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        nullable = False
    )

    image = db.Column(
        db.Text,
        default="/static/images/ing.png"
    )

    recipes = db.relationship('Recipe',secondary='recipe_has_ingredients',backref=db.backref("ingredients"))

class Instruction(db.Model):

    __tablename__ = 'instructions'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    step_no = db.Column(
        db.Integer,
        nullable = False
    )
    
    step = db.Column(
        db.Text,
        nullable = False
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey('recipes.id'))

class Unit(db.Model):

    __tablename__ = 'units'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    name = db.Column(
        db.Text,
        unique=True,
        nullable = False
    )

    abbr = db.Column(
        db.Text,
        nullable = False
    )

class RecipeIngredient(db.Model):

    __tablename__ = 'recipe_has_ingredients'

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey("recipes.id"),
        primary_key = True,
        nullable = False
    )

    ingredient_id = db.Column(
        db.Integer,
        db.ForeignKey("ingredients.id"),
        primary_key = True,
        nullable = False
    )

    unit_id = db.Column(
        db.Integer,
        db.ForeignKey("units.id"),
        nullable = False
    )

    unit = db.relationship('Unit', backref='recipe_has_ingredients')

class User(db.Model):

    __tablename__ = 'users'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    email = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    username = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    image_url = db.Column(
        db.Text,
        default="/static/images/default-pic.png"
    )

    password = db.Column(
        db.Text,
        nullable=False
    )

    def __repr__(self):
        return f"<User #{self.id}: {self.username}, {self.email}>"

    
    @classmethod
    def signup(cls, email,username,image_url,password):
        """Sign up user.
        Hashes password and adds user to system.
        """

        hashed_pwd = bcrypt.generate_password_hash(password).decode('UTF-8')

        user = User(
            email=email,
            username=username,
            image_url=image_url,
            password=hashed_pwd
        )

        db.session.add(user)
        return user

    @classmethod
    def authenticate(cls, username, password):

        user = cls.query.filter_by(username=username).first()

        if user:
            is_auth = bcrypt.check_password_hash(user.password, password)
            if is_auth:
                return user

        return False



def connect_db(app):
    db.app = app
    db.init_app(app)