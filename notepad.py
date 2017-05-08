#encoding:utf8
import conf
import bottle
from bottle import route, get, post, request, response, run, _stderr, hook, redirect, template
import json
import datetime
import copy
import time
import sys
import os
import hashlib
import shutil
import datetime
import bottlesession
import hashlib


@hook('before_request')
def output_request():
    return
    output(request.path)
    output(request.method)
    output('=header=')
    for k,v in request.headers.items():
        output('%s: %s' % (k, v))
    output('=cookie=')
    for k,v in request.cookies.items():
        output('%s: %s' % (k, v))
    output('=body=')
    output(request.body.read())
    output(request.body.read().decode('utf8'))

def timestamp():
    timestamp = str(time.time())
    return timestamp.replace('.', '')

def output(x):
    if type(x) == unicode:
        x = x.encode('gbk')
    return _stderr(str(x)+'\n')
app = {
    'title':'notepad',
    'storage': os.path.join(os.path.dirname(__file__), 'storage'),
    'session': bottlesession.PickleSession(cookie_expires=3600, session_dir=os.path.join(os.path.dirname(__file__), 'session')),
}
@get('/login')
def login():
    session = app['session'].get_session()
    return template('login', title='%s | %s' % ('login', app['title']))  
@post('/login')
def verify():
    user = request.forms.user
    if conf.user.has_key(user) and conf.user[user] == hashlib.md5(request.forms.password).hexdigest():
        home = os.path.join(app['storage'], request.forms.user)
        if not os.path.isdir(home):
            os.mkdir(home)
        session = app['session'].get_session()
        session['valid'] = True
        session['user'] = user
        app['session'].save(session)
        redirect('/')
    return template('login', title='%s | %s' % ('login', app['title']))  

def check():
    sessionid = request.get_cookie('sessionid')
    if not sessionid:
        redirect('/login')
    session = app['session'].get_session()
    if not session['valid']:
        redirect('/login')

def repair():
    t = request.query.t
    if t == '':
        t = 'checklist'
    session = app['session'].get_session()
    home = os.path.join(app['storage'], session['user'])
    return t, os.path.join(home, t) + '.txt'

@get('/')
def show():
    check()
    t, data = repair()
    content = ''
    if os.path.exists(data):
        with open(data, 'rb') as f:
            content = f.read()
    return template('index', t=t, app=app['title'], content=content)
        
@post('/')
def save():
    check()
    t, data = repair()
    content = request.body.read()
    with open(data, 'wb') as f:
        f.write(content)
    return template('index', t=t, app=app['title'], content=content)
    return ''

@get('/css/:filename')
def send_css(filename = ""):
    ''' send css requested file'''
    filename = os.path.join(os.path.join(os.path.dirname(__file__), 'css'), filename)
    if os.path.exists(filename):
        response.content_type = "text/css"
        return open(filename, "rb").read()
    return ''

@get('/js/:filename')
def send_js(filename = ""):
    ''' send js requested file'''
    filename = os.path.join(os.path.join(os.path.dirname(__file__), 'js'), filename)
    output(filename)
    if os.path.exists(filename):
        response.content_type = "text/javascript"
        return open(filename, "rb").read()
    return ''
@get('/fonts/:filename')
def send_fonts(filename = ""):
    ''' send js requested file'''
    filename = os.path.join(os.path.join(os.path.dirname(__file__), 'fonts'), filename)
    output(filename)
    if os.path.exists(filename):
        response.content_type = "application/binary"
        return open(filename, "rb").read()
    return ''
if not os.path.isdir('session'):
    os.mkdir('session')

run(host='', port=sys.argv[1], debug=True,reload=True)

