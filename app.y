from flask import Flask, jsonify

app = Flask(__name__)

@app.route("test/")
def home():
    return jsonify({
        "message": "testing new route",
        "status": "running"
    })

@app.route("/about")
def about():
    return jsonify({
        "author": "Joel",
        "purpose": "Docker practice"
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

