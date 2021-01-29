################# Flask and SQLAlchemy
from flask import render_template, request, flash, redirect, session, g, jsonify, send_file
from sqlalchemy.exc import IntegrityError

################# Other libraries
from io import BytesIO

################# Imported from external files
from app import app
from app import access
from settings import CURR_USER_KEY
from models import db, User
from forms import LoginForm, UserAddForm, EditProfileForm


@app.before_request
def add_user_to_g():
    """If we're logged in, add curr user to Flask global."""

    if CURR_USER_KEY in session:
        g.user = User.query.get(session[CURR_USER_KEY])

    else:
        g.user = None


@app.route('/signup', methods= ["POST"])
def signup():
    """Handle user signup.
    Create new user and add to DB. Redirect to home user's page.
    If form not valid, present form.
    If the there already is a user with that username: flash message
    and re-present form.
    """

    signup_form = UserAddForm()

    if signup_form.validate_on_submit():
        username = signup_form.username.data
        password = signup_form.password.data
        email = signup_form.email.data
        confirm = signup_form.password_check.data
        image_url = User.image_url.default.arg
        try:
            user = User.signup(username=username,password=password,email=email,image_url=image_url)
            flash(f"Welcome {user.username}!!!")
        except IntegrityError:
            flash("Username already taken")
            return redirect("/")
        access.do_login(user)
        return redirect("/")
    flash("Password does not match confirmed password")
    return redirect("/")

@app.route('/login', methods=["POST"])
def login():
    """Handle user login."""

    login_form = LoginForm()

    if login_form.validate_on_submit():
        user = User.authenticate(login_form.email_ver.data,
                                    login_form.password_ver.data)
        if not user:
            flash("Invalid credentials.")
            return redirect('/')
        access.do_login(user)
        flash(f"Hello, {user.username}!")
        return redirect("/")
    flash(f"Wrong credentials")
    return redirect("/")

@app.route('/logout')
@access.login_required
def logout():
    """Handle logout of user."""

    name = g.user.username
    access.do_logout()
    flash(f"See you later, {name}!!!")
    return redirect('/')

@app.route('/edit_profile', methods=['GET','POST'])
@access.login_required
def edit_profile():
    """Edit User's Profile"""

    form = EditProfileForm(obj=g.user)
    if form.validate_on_submit():
        user = User.authenticate(form.email.data,form.password.data)
        if user:
            user.username = form.username.data
            user.email = form.email.data
            db.session.commit()
            flash('User Profile was successfully edited')
            return redirect('/')
        flash("Invalid password")
        return redirect('/')
    return render_template('/users/edit-profile.html', form=form)

@app.route('/upload-profile-image', methods=['POST'])
@access.login_required
def upload_image():
    """Upload user's image to the base"""
    
    file = request.files.get('file')
    user = User.query.get(g.user.id)
    user.uploaded_image = file.read()
    db.session.commit()
    return jsonify(f'/edit_profile')

@app.route('/images/user/<int:user_id>.png')
def get_user_image(user_id):
    """Get Blob image of a user from database and convert it into readable format for image TAG"""

    user = User.query.get(user_id)
    image_binary = user.uploaded_image
    return send_file(BytesIO(image_binary),as_attachment=False, attachment_filename=f'{user_id}.png')