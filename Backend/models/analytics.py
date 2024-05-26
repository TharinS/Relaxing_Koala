from app import db

class Analytics(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    food_item_id = db.Column(db.Integer, db.ForeignKey('food_item.id'), nullable=False)
    counter = db.Column(db.Integer, default=0)

    food_item = db.relationship('FoodItem', backref=db.backref('analytics', lazy=True))
