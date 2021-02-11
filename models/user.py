from models import db, bcrypt

class User(db.Model):
    """User Model"""

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
        """Need to authenticate the person who he/she claims is/Also needed for edit user's info"""

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
