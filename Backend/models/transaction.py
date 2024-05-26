from app import db

class Transaction(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    order_id = db.Column(db.Integer, db.ForeignKey('order.id'), nullable=False)
    transaction_type = db.Column(db.Enum('cash', 'card'), nullable=False)
    transaction_time = db.Column(db.DateTime, default=db.func.current_timestamp())
    amount = db.Column(db.Numeric(10, 2), nullable=False)
