import os
from secrets import key_gen

class Config(object):
    """Parent has all fields needed for production"""
    DEBUG = False
    TESTING = False
    SECRET_KEY = os.environ.get('SECRET_KEY',key_gen)
    SQLALCHEMY_DATABASE_URI = 'keto_life'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_ECHO = False
    SESSION_COOKIE_SECURE = True
    SEND_FILE_MAX_AGE_DEFAULT = 0
    DEBUG_TB_INTERCEPT_REDIRECTS = False
    WTF_CSRF_CHECK_DEFAULT = False
    SECURITY_CSRF_PROTECT_MECHANISMS = ["session", "basic"]

class ProductionConfig(Config):
    pass

class DevelopmentConfig(Config):
    """lets make some fields be overidden"""
    DEBUG = True
    SESSION_COOKIE_SECURE = False
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL', 'postgres:///keto_life')
    DEBUG_TB_INTERCEPT_REDIRECTS = True
