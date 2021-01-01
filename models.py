from flask_bcrypt import Bcrypt
from flask_sqlalchemy import SQLAlchemy
import datetime

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

    servings = db.Column(
        db.Integer
    )

    tcook = db.Column(
        db.Integer
    )

    calories = db.Column(
        db.Float
    )

    mealtype = db.Column(
        db.Text
    )

    dishtype = db.Column(
        db.Text
    )

    source = db.Column(
        db.Text
    )

    url = db.Column(
        db.Text
    )

    user_id = db.Column(
        db.Integer, 
        db.ForeignKey('users.id'), nullable=True)
    
    average_rate = db.Column(
        db.Float
    )

    local_image = db.Column(
        db.LargeBinary
    )
    

    # through relationship to have an access to all ingredients of the recipe
    ingredients = db.relationship('Ingredient', backref="recipe", cascade="all, delete")
    instructions = db.relationship('Instruction', backref="recipe", cascade="all, delete")
    nutrients = db.relationship('Nutrient', secondary='recipe_has_nutrients', backref="recipe")
    assignments = db.relationship('RecipeNutrient', backref='recipe')
    comments = db.relationship('Comment', backref='recipe')
    ratings = db.relationship('Rating', backref="recipe")

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
        nullable=False
    )

    image = db.Column(
        db.Text,
        default="/static/images/ing.png"
    )

    recipe_id = db.Column(
        db.Integer,
        db.ForeignKey('recipes.id'))


class Instruction(db.Model):

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


class Nutrient(db.Model):

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

    units = db.relationship('Unit', backref='nutrient')


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
        nullable=False
    )


class RecipeNutrient(db.Model):

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

class Product(db.Model):

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


class User(db.Model):

    __tablename__ = 'users'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    username = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    password = db.Column(
        db.Text,
        nullable=False
    )

    email = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    image_url = db.Column(
        db.Text,
        default="/static/images/default-pic.png"
    )

    uploaded_image = db.Column(
        db.LargeBinary
    )

    def __repr__(self):
        return f"<User #{self.id}: {self.username}, {self.email}>"

    @classmethod
    def signup(cls, username, password, email, image_url):
        """Sign up user.
        Hashes password and adds user to system.
        """

        hashed_pwd = bcrypt.generate_password_hash(password).decode('UTF-8')

        # import pdb
        # pdb.set_trace()

        user = User(
            username=username,
            password=hashed_pwd,
            email=email,
            image_url=image_url
        )

        db.session.add(user)
        db.session.commit()
        return user

    @classmethod
    def authenticate(cls, email, password):

        user = cls.query.filter_by(email=email).first()

        if user:
            is_auth = bcrypt.check_password_hash(user.password, password)
            if is_auth:
                return user

        return False

    def serialize(self):
        """Serialize our object message to dictionary for json"""
        return {
            "id": self.id,
            "usename": self.username,
            "email": self.email,
            "password": self.password,
            "image_url": self.image_url
        }

    recipes = db.relationship('Recipe', backref='user')


class Rating(db.Model):
    """Many-to-Many relationship"""
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

class Comment(db.Model):

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
        db.ForeignKey('users.id'), nullable=True)

    recipe_id = db.Column(
        db.Integer, 
        db.ForeignKey('recipes.id'), nullable=True)

    created_at = db.Column(
        db.DateTime,
        default = datetime.datetime.utcnow
    )

    users = db.relationship('User', backref="comment")


def connect_db(app):
    db.app = app
    db.init_app(app)
