from app import db

class FoodItem(db.Model):
    __tablename__ = 'food_item'
    id = db.Column(db.Integer, primary_key=True)
    foodname = db.Column(db.String(255), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    description = db.Column(db.Text)
    category = db.Column(db.String(255))
    available = db.Column(db.Boolean, default=True)
    asset = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp(), nullable=False)
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp(), nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'foodname': self.foodname,
            'price': float(self.price),  # Convert Decimal to float for JSON serialization
            'description': self.description,
            'category': self.category,
            'available': self.available,
            'asset': self.asset,
            'created_at': self.created_at,
            'updated_at': self.updated_at
        }
