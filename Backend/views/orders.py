from flask import Blueprint, request, jsonify
from app import db
from models.order import Order
from models.analytics import Analytics

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders', methods=['POST'])
def create_order():
    data = request.get_json()
    new_order = Order(
        table_number=data['table_number'],
        creator_id=data['creator_id'],
        creator_type=data['creator_type'],
        order_time=data['order_time'],
        order_type=data['order_type'],
        delivery_id=data.get('delivery_id'),
        total_price=data['total_price']
    )
    db.session.add(new_order)
    db.session.commit()

    # Update analytics counters
    for item_id in data['items']:
        analytics_record = Analytics.query.filter_by(food_item_id=item_id).first()
        if analytics_record:
            analytics_record.counter += 1
        else:
            new_analytics_record = Analytics(food_item_id=item_id, counter=1)
            db.session.add(new_analytics_record)
        db.session.commit()

    return jsonify({'id': new_order.id}), 201

@orders_bp.route('/orders', methods=['GET'])
def get_orders():
    orders = Order.query.all()
    return jsonify([order.__dict__ for order in orders]), 200

@orders_bp.route('/orders/<int:id>', methods=['GET'])
def get_order(id):
    order = Order.query.get_or_404(id)
    return jsonify(order.__dict__), 200

@orders_bp.route('/orders/<int:id>', methods=['PUT'])
def update_order(id):
    data = request.get_json()
    order = Order.query.get_or_404(id)
    for key, value in data.items():
        setattr(order, key, value)
    db.session.commit()
    return jsonify(order.__dict__), 200

@orders_bp.route('/orders/<int:id>', methods=['DELETE'])
def delete_order(id):
    order = Order.query.get_or_404(id)

    # Update analytics counters
    for item_id in order.items:
        analytics_record = Analytics.query.filter_by(food_item_id=item_id).first()
        if analytics_record:
            analytics_record.counter -= 1
        db.session.commit()

    db.session.delete(order)
    db.session.commit()
    return '', 204
