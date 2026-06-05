from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/')
def home():
    return '<h1>DevOps CI/CD Pipeline — It Works!</h1>'


@app.route('/health')
def health():
    return jsonify({'status': 'healthy', 'service': 'devops-app'})




if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
