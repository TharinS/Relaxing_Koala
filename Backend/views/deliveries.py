from flask import Blueprint, request, jsonify
from app import db
from models.delivery import Delivery

deliveries_bp = Blueprint('deliveries', __name__)

@deliveries_bp.route('/deliveries', methods=['POST'])
def create_delivery():
    data = request.get_json()
    new_delivery = Delivery(
        address=data['address'],
        state=data['state'],
        postcode=data['postcode'],
        delivery_time=data['delivery_time']
    )
    db.session.add(new_delivery)
    db.session.commit()
    return jsonify({'id': new_delivery.id}), 201

@deliveries_bp.route('/deliveries', methods=['GET'])
def get_deliveries():
    deliveries = Delivery.query.all()
    return jsonify([delivery.to_dict() for delivery in deliveries]), 200

@deliveries_bp.route('/deliveries/<int:id>', methods=['GET'])
def get_delivery(id):
    delivery = Delivery.query.get_or_404(id)
    return jsonify(delivery.to_dict()), 200

@deliveries_bp.route('/deliveries/<int:id>', methods=['PUT'])
def update_delivery(id):
    data = request.get_json()
    delivery = Delivery.query.get_or_404(id)
    for key, value in data.items():
        setattr(delivery, key, value)
    db.session.commit()
    return jsonify(delivery.to_dict()), 200

@deliveries_bp.route('/deliveries/<int:id>', methods=['DELETE'])
def delete_delivery(id):
    delivery = Delivery.query.get_or_404(id)
    db.session.delete(delivery)
    db.session.commit()
    return '', 204
