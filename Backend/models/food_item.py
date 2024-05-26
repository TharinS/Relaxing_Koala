from app import db

class FoodItem(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    foodname = db.Column(db.String(255), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    description = db.Column(db.Text)
    category = db.Column(db.String(255))
    available = db.Column(db.Boolean, default=True)
    asset = db.Column(db.String(255))

    def to_dict(self):
        return {
            'id': self.id,
            'foodname': self.foodname,
            'price': float(self.price),  # Convert Decimal to float for JSON serialization
            'description': self.description,
            'category': self.category,
            'available': self.available,
            'asset': self.asset
        }
