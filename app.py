from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({"status": "secure", "message": "Production Flask App Running"})

if __name__ == '__main__':
    # Never use debug=True in production
    app.run(host='0.0.0.0', port=5000)