from functools import wraps
from flask import redirect, request, session, url_for

def login_validation(f):
    @wraps(f)
    def check_session(*args, **kwargs):
        if 'user_id' not in session and request.referrer != url_for('login'):  # Check for login page referral
            return redirect(url_for('login', msg="User not logged in, redirecting to login page"))
        return f(*args, **kwargs)
    return check_session

def clear_flash():
    session.pop('_flashes', None)
    return {}
