from wtforms import TextAreaField
from wtforms.validators import InputRequired
from flask_wtf import FlaskForm


class NutritionTranslatorForm(FlaskForm):

    query = TextAreaField('Enter the name of the food')