from wtforms import TextAreaField, StringField, IntegerField, FileField, SelectField
from wtforms.validators import InputRequired, DataRequired, Optional
from flask_wtf import FlaskForm


class NewRecipeForm(FlaskForm):

    title = StringField("Recipe Title", validators=[InputRequired("Please Enter the Recipe Title")])
    ingredients = StringField('Ingredients', validators=[InputRequired("Please Enter the Ingredients Used")])
    instructions = StringField('Instructions', validators=[InputRequired("Please Enter the Directions to prepare youe recipe")])
    servings = IntegerField('How many servings', validators=[InputRequired("Please enter the number of servings")])
    time_prep = IntegerField('Time of preparation', validators=[InputRequired("Please enter the time it takes to prepare this recipe")])
    time_cook = IntegerField('Time to cook', validators=[InputRequired("Please enter the time it takes to cook this recipe")])
    image = FileField("Image Upload", validators=[Optional()])
    meal_type = SelectField('Meal Type', choices = [ (None, '--'),
                 ('breakfast', 'Breakfast'), ('lunch', 'Lunch'), 
                 ('dinner','Dinner'),('snack', 'Snack'),('teatime','Teatime')
                ],default=None)
