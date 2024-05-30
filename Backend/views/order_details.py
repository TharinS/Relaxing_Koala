from flask import Blueprint, request, jsonify
from app import db
from models.order_detail import OrderDetail

order_details_bp = Blueprint('order_details', __name__)

@order_details_bp.route('/order_details', methods=['POST'])
def create_order_detail():
    data = request.get_json()
    new_order_detail = OrderDetail(
        order_id=data['order_id'],
        food_item_id=data['food_item_id'],
        quantity=data['quantity'],
        price=data['price']
    )
    db.session.add(new_order_detail)
    db.session.commit()
    return jsonify({'id': new_order_detail.id}), 201

@order_details_bp.route('/order_details', methods=['GET'])
def get_order_details():
    order_details = OrderDetail.query.all()
    return jsonify([detail.to_dict() for detail in order_details]), 200

@order_details_bp.route('/order_details/<int:id>', methods=['GET'])
def get_order_detail(id):
    order_detail = OrderDetail.query.get_or_404(id)
    return jsonify(order_detail.to_dict()), 200

@order_details_bp.route('/order_details/<int:id>', methods=['PUT'])
def update_order_detail(id):
    data = request.get_json()
    order_detail = OrderDetail.query.get_or_404(id)
    for key, value in data.items():
        setattr(order_detail, key, value)
    db.session.commit()
    return jsonify(order_detail.to_dict()), 200

@order_details_bp.route('/order_details/<int:id>', methods=['DELETE'])
def delete_order_detail(id):
    order_detail = OrderDetail.query.get_or_404(id)
    db.session.delete(order_detail)
    db.session.commit()
    return '', 204
