import sys
sys.path.append('..')
import util
import bottle
import os
from bottle import template, static_file
def init(app):
    util.output('wmd init')
    global _app
    _app = app
    bottle.TEMPLATE_PATH.append(os.path.join(os.path.dirname(__file__), 'views'))
    route()
def route():
    _app.route('/wmd-test', 'GET', test)
    _app.route('/wmd/<name>.css', 'GET', css)
    _app.route('/wmd/<name>.js', 'GET', js)

def test():
    return template('wmd-test')

def css(name):
    util.output(name)
    util.output(os.path.join(os.path.dirname(__file__)))
    return static_file(name+'.css', os.path.join(os.path.dirname(__file__)))

def js(name):
    return static_file(name+'.js', os.path.join(os.path.dirname(__file__)))

if __name__ == '__main__':
    app = bottle.Bottle()
    init(app)
    app.run(host='',
            port=8080 if len(sys.argv) < 2 else int(sys.argv[1]),
            debug = True,
            reload = True)
