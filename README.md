flask-balabas
=============

An angularjs boilerplate for flask / py3 with yeomen and coffeescript
--------------------------------------------------------------------------------

This skeleton uses Flask-Mako to render the angular templates,
so you can use flask environment in angular templates.

MVC pattern comes from  [funkenstein/flask-mvc](https://github.com/funkenstein/flask-mvc),
so flask controllers appends automatically.

***Get started***

**** 1. Install yeomen angular. ****
```sh
  ~$ npm install -g generator-angular
```

- Create a python3 virtual env and activate it.
```sh
  ~$ virtualenv -p python3 py3-sandbox
  ~$ cd ./py3-sandbox
  ~$ source ./bin/activate
```

**** 2. Clone this repo and install requirements. ****
```sh
(env)~$ git clone https://github.com/nesforge/flask-balabas.git
(env)~$ cd ./flask-balabas
(env)~$ pip install -r requirements.txt
```

**** 3. Setup the app in develop mode and run it. ****
```sh
(env)~$ python setup.py develop
(env)~$ python run.py

...bla bla bla...
...http://localhost:5000...
```

**** 4. Use the yeoman generator. ****
```sh
(env)~$ cd ./balabas
(env)~$ yo angular:route myroute --coffee
```

**** 5. Give a star to this project. ****

--------------------------------------------------------------------------------
****Licence: MIT****
