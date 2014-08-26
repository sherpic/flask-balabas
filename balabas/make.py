import os
from flask import Flask
from flask.ext.mako import MakoTemplates
from flask.ext.mail import Mail
from flask.ext.sqlalchemy import SQLAlchemy
from flask_wtf.csrf import CsrfProtect
#todo: babel = Babel(app)from flask.ext.babel import Babel, gettext as _

#----------------------------------------------------------------

def make_app(config="config.py"):

    app = Flask(__name__)

    #----------------------------
    #helpers
    app.jinja_env.globals['icon'] =\
        lambda x:"<i class='glyphicon glyphicon-%s'></i>"%x

    #todo: app.jinja_env.globals['_'] = _
    app.template_folder = "app"

    app.config.from_pyfile(config)
    return app

#-----------------------------------------------------------------

app = make_app()
db = SQLAlchemy(app)
mail = Mail(app)
csrf = CsrfProtect(app)
#todo: babel = Babel(app)

mako = MakoTemplates()
mako.init_app(app)

