from app import db

class OrderDetail(db.Model):
    __tablename__ = 'order_details'
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.Integer, db.ForeignKey('orders.id'), nullable=False)
    food_item_id = db.Column(db.Integer, db.ForeignKey('food_item.id'), nullable=False)
    quantity = db.Column(db.Integer, nullable=False, default=1)
    price = db.Column(db.Numeric(10, 2), nullable=False)

    order = db.relationship('Order', back_populates='details')
    food_item = db.relationship('FoodItem')

    def to_dict(self):
        return {
            'id': self.id,
            'order_id': self.order_id,
            'food_item_id': self.food_item_id,
            'quantity': self.quantity,
            'price': float(self.price),
            'food_item': self.food_item.to_dict() if self.food_item else None
        }
