from app import db

class Order(db.Model):
    __tablename__ = 'orders'
    id = db.Column(db.Integer, primary_key=True)
    table_number = db.Column(db.Integer, nullable=True)
    creator_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    creator_type = db.Column(db.Enum('employee', 'customer', name='creator_type_enum'), nullable=False)
    order_time = db.Column(db.DateTime, nullable=False)
    order_type = db.Column(db.Enum('dine-in', 'delivery', name='order_type_enum'), nullable=False)
    delivery_id = db.Column(db.Integer, db.ForeignKey('delivery.id'), nullable=True)
    total_price = db.Column(db.Numeric(10, 2), nullable=True)
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp(), nullable=False)
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp(), nullable=False)

    details = db.relationship('OrderDetail', back_populates='order')
