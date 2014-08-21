import os
from flask import Flask
from flask.ext.mako import MakoTemplates
#----------------------------------------------------------------

def make_app(config="config.py"):

    app = Flask(__name__)
    app.jinja_env.globals['icon'] =\
        lambda x:"<i class='glyphicon glyphicon-%s'></i>"%x
    app.template_folder = "app"
    mako = MakoTemplates()
    mako.init_app(app)

    #db = SQLAlchemy(app)

    return app#, db

#-----------------------------------------------------------------

app = make_app()#app, db = make_app()

