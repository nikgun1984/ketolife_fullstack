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

    ingr = db.Column(
        db.Text,
        nullable=False
    )

    url = db.Column(
        db.Text,
        default="/static/images/default-recipe.png"
    )

    summary = db.Column(
        db.Text
    )

    no_serv = db.Column(
        db.Integer
    )

    ttime = db.Column(
        db.Integer
    )

    img = db.Column(
        db.Text
    )

    prep = db.Column(
        db.Text
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