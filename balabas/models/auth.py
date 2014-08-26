from balabas import db, app
from datetime import datetime



from flask.ext.security import (
    Security,
    SQLAlchemyUserDatastore,
    UserMixin,
    RoleMixin
)


user_roles = db.Table('user_roles',
    db.Column('id', db.Integer(), primary_key=True),
    db.Column(
        'user_id', db.Integer(), db.ForeignKey('users.user_id', ondelete='CASCADE')),
    db.Column(
        'role_id', db.Integer(), db.ForeignKey('roles.id', ondelete='CASCADE'))
)

#
class Role(db.Model, RoleMixin):

    __tablename__ = "roles"
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.Unicode(50), unique=True)

class User(db.Model, UserMixin):

    __tablename__ = "users"
    id = db.Column('user_id',db.Integer , primary_key=True)
    username = db.Column('username', db.Unicode(20), unique=True , index=True)
    password = db.Column('password' , db.Unicode(10))

    email = db.Column('email',db.Unicode(50),unique=True , index=True)
    registered_on = db.Column('registered_on' , db.DateTime)
    active = db.Column(db.Boolean(), nullable=False, default=False)
    confirmed_at = db.Column(db.DateTime())

    roles = db.relationship('Role', secondary=user_roles,
        backref=db.backref('users', lazy='dynamic')
    )



    def __repr__(self):
        return '<User %r>' % (self.username)


user_datastore = SQLAlchemyUserDatastore(db, User, Role)
security = Security(app, user_datastore)

@app.before_first_request
def create_user():
    db.create_all()

    if db.session.query(User).count() > 0:
        return
    role = user_datastore.create_role(name='manager')
    user = user_datastore.create_user(
        email='manager@site.com',
        password='$2a$12$lvoQd4v9ktXFZALAgTcT8uFSgVR7O38mXiCy0BAWQCsPzVoPhKNmm',
    )
    user_datastore.add_role_to_user(user, role)
    db.session.commit()

