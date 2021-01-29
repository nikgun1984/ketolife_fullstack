from app import app
from werkzeug.exceptions import InternalServerError
from flask import render_template

@app.errorhandler(404)
def page_not_found(e):
    # note that we set the 404 status explicitly
    return render_template('/errors/404.html'), 404

@app.errorhandler(405)
def resource_not_found(e):
    # note that we set the 405 status explicitly
    return render_template('/errors/405.html'), 405

@app.errorhandler(InternalServerError)
def handle_500(e):
    original = getattr(e, "original_exception", None)

    if original is None:
        # direct 500 error, such as abort(500)
        return render_template("/errors/500.html"), 500

    # wrapped unhandled error
    return render_template("/errors/500_unhandled.html", e=original), 500