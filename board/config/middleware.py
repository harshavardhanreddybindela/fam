from functools import wraps
from flask import redirect, session, url_for

# Define the login_required decorator
def login_validation(f):
    @wraps(f)
    def check_session(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login',msg="User not logged in, redirecting to login page"))
        return f(*args, **kwargs)
    return check_session
