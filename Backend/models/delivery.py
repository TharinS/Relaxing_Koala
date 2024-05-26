from app import db

class Delivery(db.Model):
    __tablename__ = 'delivery'
    id = db.Column(db.Integer, primary_key=True)
    address = db.Column(db.String(255), nullable=False)
    state = db.Column(db.String(255), nullable=False)
    postcode = db.Column(db.String(10), nullable=False)
    delivery_time = db.Column(db.DateTime, nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp(), nullable=False)
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp(), nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'address': self.address,
            'state': self.state,
            'postcode': self.postcode,
            'delivery_time': self.delivery_time,
            'created_at': self.created_at,
            'updated_at': self.updated_at
        }
