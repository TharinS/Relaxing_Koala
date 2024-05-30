from app import db

class Reservation(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    reservation_time = db.Column(db.DateTime, nullable=False)
    table_number = db.Column(db.Integer, nullable=False)
    number_of_guests = db.Column(db.Integer, default=1)
    special_requests = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=db.func.current_timestamp(), nullable=False)
    updated_at = db.Column(db.DateTime, default=db.func.current_timestamp(), onupdate=db.func.current_timestamp(), nullable=False)

    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'reservation_time': self.reservation_time.isoformat(),
            'table_number': self.table_number,
            'number_of_guests': self.number_of_guests,
            'special_requests': self.special_requests,
            'created_at': self.created_at.isoformat(),
            'updated_at': self.updated_at.isoformat()
        }
