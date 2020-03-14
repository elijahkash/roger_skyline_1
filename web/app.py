from flask import Flask

app = Flask(
	__name__,
	static_url_path='/home/servuser/roger/web/',
	static_folder='static'
)


@app.route('/<path:path>')
def send_file(path):
	return app.send_static_file(path)


@app.route('/')
def root():
	return app.send_static_file('index.html')


if __name__ == '__main__':
	app.run(debug=False, host='0.0.0.0', port=4321)
