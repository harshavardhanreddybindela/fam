from flask import Blueprint,render_template

bp = Blueprint("pages", __name__)

@bp.route("/")
def home():
    return render_template("pages/home.html")

@bp.route("/about")
def about():
    return render_template("pages/about.html")

@bp.route("/register")
def register():
    return render_template("pages/add_student.html")

@bp.route("/menu")
def menu():
    return render_template("pages/menu.html")
