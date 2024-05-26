from flask import Blueprint, request, jsonify
from app import db
from models.reservation import Reservation

reservations_bp = Blueprint('reservations', __name__)

@reservations_bp.route('/reservations', methods=['POST'])
def create_reservation():
    data = request.get_json()
    new_reservation = Reservation(**data)
    db.session.add(new_reservation)
    db.session.commit()
    return jsonify({'id': new_reservation.id}), 201

@reservations_bp.route('/reservations', methods=['GET'])
def get_reservations():
    reservations = Reservation.query.all()
    return jsonify([reservation.__dict__ for reservation in reservations]), 200

@reservations_bp.route('/reservations/<int:id>', methods=['GET'])
def get_reservation(id):
    reservation = Reservation.query.get_or_404(id)
    return jsonify(reservation.__dict__), 200

@reservations_bp.route('/reservations/<int:id>', methods=['PUT'])
def update_reservation(id):
    data = request.get_json()
    reservation = Reservation.query.get_or_404(id)
    for key, value in data.items():
        setattr(reservation, key, value)
    db.session.commit()
    return jsonify(reservation.__dict__), 200

@reservations_bp.route('/reservations/<int:id>', methods=['DELETE'])
def delete_reservation(id):
    reservation = Reservation.query.get_or_404(id)
    db.session.delete(reservation)
    db.session.commit()
    return '', 204
