from app import db

class Order(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    table_number = db.Column(db.Integer)
    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator_type = db.Column(db.Enum('employee', 'customer'), nullable=False)
    order_time = db.Column(db.DateTime, nullable=False)
    order_type = db.Column(db.Enum('dine-in', 'delivery'), nullable=False)
    delivery_id = db.Column(db.Integer, db.ForeignKey('delivery.id'))
    total_price = db.Column(db.Numeric(10, 2))
