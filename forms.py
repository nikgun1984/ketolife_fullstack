from wtforms import Form, FormField, StringField, IntegerField, FileField, SelectField, FieldList, TextAreaField, FloatField, PasswordField
from wtforms.validators import InputRequired, DataRequired, Optional, Length, Email, EqualTo
from flask_wtf import FlaskForm

class AddIngredientForm(Form):
    """Subform.
        CSRF is disabled for this subform (using `Form` as parent class) because
        it is never used by itself.
    """
    ingredient = StringField('Ingredient', validators=[InputRequired("Please Enter the Ingredient Used")])
    unit = SelectField('Unit', validators=[InputRequired("Select one of the measurement unit")])
    amount = FloatField('Amount', validators=[InputRequired("Please Enter the Amount Used")])

class AddInstructionForm(Form):
    """Subform.
        CSRF is disabled for this subform (using `Form` as parent class) because
        it is never used by itself.
    """
    step = TextAreaField('Directions', validators=[InputRequired("Please Enter the Directions to prepare your recipe")])

class TitleRecipeForm(FlaskForm):
    """Title for Recipe Form"""
    title = StringField("Recipe Title", validators=[InputRequired("Please Enter the Recipe Title")],render_kw={"placeholder": "Title your recipe"})

class OtherDetailsForm(Form):
    """Addition to Recipe form"""
    servings = IntegerField('How many servings', validators=[InputRequired("Please enter the number of servings")])
    time_prep = IntegerField('Time of preparation', validators=[InputRequired("Please enter the time it takes to prepare this recipe")])
    time_cook = IntegerField('Time to cook', validators=[InputRequired("Please enter the time it takes to cook this recipe")])
    image = FileField("Image Upload", validators=[Optional()])
    meal_type = SelectField('Meal Type', choices = [ (None, '--'),
                 ('breakfast', 'Breakfast'), ('lunch', 'Lunch'), 
                 ('dinner','Dinner'),('snack', 'Snack'),('teatime','Teatime')
                ],default=None)

class NewRecipeForm(FlaskForm):
    """Form for creating recipe"""
    title = FormField(TitleRecipeForm)
    ingredients = FieldList(FormField(AddIngredientForm),min_entries=1,max_entries=20)
    instructions = FieldList(FormField(AddInstructionForm),min_entries=1,max_entries=20)
    # ingredients = StringField('Ingredients', validators=[InputRequired("Please Enter the Ingredients Used")])
    # instructions = StringField('Instructions', validators=[InputRequired("Please Enter the Directions to prepare youe recipe")])
    details = FormField(OtherDetailsForm)


class LoginForm(FlaskForm):
    """Login form."""
    email_ver = StringField('E-mail', render_kw={"placeholder": "Email Address"},validators=[DataRequired(), Email()])
    password_ver = PasswordField('Password', render_kw={"placeholder": "Password"},validators=[Length(min=6)])


class UserAddForm(FlaskForm):
    """Form for adding users."""
    username = StringField('Username', render_kw={"placeholder": "Username"}, validators=[DataRequired()])
    email = StringField('E-mail', render_kw={"placeholder": "Email Address"}, validators=[DataRequired(), Email()])
    password = PasswordField('Password', render_kw={"placeholder": "Password"}, validators=[Length(min=6),InputRequired("Please Enter your Password"),EqualTo('password_check', message="Passwords must match")])
    password_check = PasswordField('Password', render_kw={"placeholder": "Confirm Password"}, validators=[Length(min=6)])
    # image_url = StringField('(Optional) Image URL')

class SearchIngredientForm(FlaskForm):
    """Ingredient Search Form"""
    item = StringField('Ingredient', render_kw={"placeholder": "Search for your ingredient"}, validators=[DataRequired()])


class CommentsForm(FlaskForm):
    """Comments form"""
    comment = TextAreaField('Leave a Comment if You Like', render_kw={"rows":"3","id":"comment"},validators=[InputRequired("You cannot submit empty form")])

class EditProfileForm(FlaskForm):
    """update and edit user's information in the database"""
    username = StringField('Username', render_kw={"placeholder": "Email Address","class":"form-control"}, validators=[DataRequired()])
    email = StringField('E-mail', render_kw={"placeholder": "Email Address","class":"form-control"}, validators=[DataRequired(), Email()])
    password  = PasswordField('Password', render_kw={"placeholder": "Password","class":"form-control"}, validators=[Length(min=6),InputRequired("Please Enter your Password"),EqualTo('password_check', message="Passwords must match")])
    password_check = PasswordField('Password', render_kw={"placeholder": "Confirm Password","class":"form-control"}, validators=[Length(min=6)])      