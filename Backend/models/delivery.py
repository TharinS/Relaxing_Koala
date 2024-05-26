from app import db

class Delivery(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    address = db.Column(db.String(255), nullable=False)
    state = db.Column(db.String(255), nullable=False)
    postcode = db.Column(db.String(10), nullable=False)
    delivery_time = db.Column(db.DateTime, nullable=False)
