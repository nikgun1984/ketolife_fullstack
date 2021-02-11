from models import db

class Recipe(db.Model):
    """Recipe Model"""

    __tablename__ = 'recipes'

    id = db.Column(
        db.Integer,
        primary_key=True,
        autoincrement=True
    )

    title = db.Column(
        db.Text,
        nullable=False,
        unique=True
    )

    image = db.Column(
        db.Text,
        default="/static/images/default-recipe.png"
    )

    servings = db.Column(
        db.Integer,
        nullable=False
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
    comments = db.relationship('Comment', backref='recipe')
    ratings = db.relationship('Rating', backref="recipe")
    # Many-to-Many Relationship (access to associatin table)
    assignments = db.relationship('RecipeNutrient', backref='recipe')

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