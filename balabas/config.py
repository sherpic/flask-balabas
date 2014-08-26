import os

DEBUG = True
PKG_NAME = 'balabas'
ANGULAR_HOME = "/"

#--------------------------------------------------------------
# Session
SECRET_KEY = "john fucks json but joseph cheats on jinja"
SESSION_COOKIE_NAME = "nipple"
CSRF_ENABLED = True

#--------------------------------------------------------------
# Database
SQLALCHEMY_DATABASE_URI = "sqlite:///test.db"

#--------------------------------------------------------------
# Language
BABEL_DEFAULT_LOCALE = 'en_US'
BABEL_DEFAULT_TIMEZONE = 'UTC'

#--------------------------------------------------------------
# Flask-Mail
MAIL_SERVER   = 'smtp.gmail.com'
MAIL_PORT     = 465
MAIL_USE_SSL  = True
MAIL_USE_TLS  = True
MAIL_USERNAME = 'email@example.com'
MAIL_PASSWORD = 'password'
MAIL_DEFAULT_SENDER = '"Sender" <noreply@example.com>'

#--------------------------------------------------------------
# Flask-Security
SECURITY_PASSWORD_HASH = 'bcrypt'
SECURITY_PASSWORD_SALT = 'john fuck json'
SECURITY_REGISTERABLE = True
SECURITY_CHANGEABLE = True
SECURITY_EMAIL_SENDER = "no-reply@bobik.su"
SECURITY_URL_PREFIX = '/user'
SECURITY_POST_LOGIN_VIEW = '/user/data'
SECURITY_POST_LOGOUT_VIEW = '/user/data'

#--------------------------------------------------------------
# Shop
SHOP_CURRENCY = "$"

