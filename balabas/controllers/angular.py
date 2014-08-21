import os

from flask import (
	request,
	flash,
	url_for,
	redirect,
	render_template,
	abort,
	send_from_directory,
	send_file,
	make_response
)

from balabas import app#, db
from flask.ext.mako import render_template
from subprocess import Popen, PIPE
import shlex

def read_stdout(command):
  """from flask snippets"""
  args = shlex.split(command)
  def renderer(script):
    if isinstance(script, str):
      try: script = open(script)
      except FileNotFoundError:
        return abort(404)
    else:
      return abort(404)

    process=Popen(args, stdin=script,stdout=PIPE, stderr=PIPE)

    returncode = process.wait()
    stdoutdata, stderrdata = process.communicate()

    if returncode != 0:
      return abort(404)
    return stdoutdata

  return renderer(args[-1])

def read_file(path):
  try:
    with open(path,'r') as f:
      string = f.read()
      f.close()
      return string
  except FileNotFoundError:
    return abort(404)

HOME = app.config.get('ANGULAR_HOME', '/')
PREFIX = HOME.endswith('/') and HOME[:-1] or HOME

@app.route(HOME)
def angular_home():
  return render_template("index.html")

@app.route('/views/<path:url>')
@app.route(PREFIX+'/views/<path:url>')
def angular_views(url):
  return render_template('/views/'+url)


@app.route('/404.html')
@app.route(PREFIX+'/404.html')
def angular_404():
  return render_template('404.html')

@app.route('/styles/<path:url>')
@app.route(PREFIX+'/styles/<path:url>')
def angular_styles(url):
  result = read_file(app.root_path + "/app/styles/" + url)
  return make_response(result)

@app.route('/scripts/<path:url>')
@app.route(PREFIX+'/scripts/<path:url>')
def angular_coffee(url):
  path = app.root_path + "/app/scripts/" + url.replace('.js','.coffee')
  result = read_stdout("coffee -cs "+path)
  return make_response(result)

@app.route('/images/<path:url>')
@app.route(PREFIX+'/images/<path:url>')
def angular_images(url):
  file = app.root_path + "/app/images/" + url
  return send_file(file)


@app.route('/bower_components/<path:filename>')
@app.route(PREFIX+'/bower_components/<path:filename>')
def get_bower_component(filename):
  return send_from_directory(app.root_path + '/bower_components/', filename)

