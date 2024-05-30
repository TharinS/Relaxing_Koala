from app import db

class Transaction(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    order_id = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    transaction_type = db.Column(db.Enum('cash', 'card'), nullable=False)
    transaction_time = db.Column(db.DateTime, default=db.func.current_timestamp())
    amount = db.Column(db.Numeric(10, 2), nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp())
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp())

    user = db.relationship('User')
    order = db.relationship('Order')

    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'order_id': self.order_id,
            'transaction_type': self.transaction_type,
            'transaction_time': self.transaction_time.isoformat(),
            'amount': str(self.amount),
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
