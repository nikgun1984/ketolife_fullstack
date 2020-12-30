# Check for register and login fields
from sqlalchemy.exc import IntegrityError
import requests

def is_empty(val,field):
    if not val:
        raise ValueError(f"{field} cannot be empty...")

def is_empty(username,field):
    """Checking for username validity"""
    if len(username) < 5:
        raise ValueError(f"{field} cannot be less than 5 characters...")

def is_valid_email(email, field):
    """Checking for email validity"""
    response = requests.get("https://isitarealemail.com/api/email/validate", params = {'email': email})
    status = response.json()['status']
    if status != "valid":
        raise ValueError(f"{field} is not valid")

def is_password_valid(passw,confirm_pass,field):
    """Check if password valid"""
    if len(passw) < 6:
        raise ValueError(f"{field} should be greater than 5 characters")
    if passw != confirm_pass:
        raise ValueError(f"{field}s must match")
