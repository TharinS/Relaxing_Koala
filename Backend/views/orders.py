from flask import Blueprint, request, jsonify
from app import db
from models.order import Order
from models.order_detail import OrderDetail
from models.analytics import Analytics

orders_bp = Blueprint('orders', __name__)

@orders_bp.route('/orders', methods=['POST'])
def create_order():
    data = request.get_json()
    new_order = Order(
        table_number=data.get('table_number'),
        creator_id=data['creator_id'],
        creator_type=data['creator_type'],
        order_time=data['order_time'],
        order_type=data['order_type'],
        delivery_id=data.get('delivery_id'),
        total_price=data['total_price']
    )
    db.session.add(new_order)
    db.session.commit()

    # Create order details
    if 'items' in data:
        for item in data['items']:
            new_order_detail = OrderDetail(
                order_id=new_order.id,
                food_item_id=item['id'],
                quantity=item['quantity'],
                price=item['price']
            )
            db.session.add(new_order_detail)

            # Update analytics counters
            analytics_record = Analytics.query.filter_by(food_item_id=item['id']).first()
            if analytics_record:
                analytics_record.counter += 1
            else:
                new_analytics_record = Analytics(food_item_id=item['id'], counter=1)
                db.session.add(new_analytics_record)
        db.session.commit()

    return jsonify({'id': new_order.id}), 201

@orders_bp.route('/orders', methods=['GET'])
def get_orders():
    orders = Order.query.all()
    orders_list = [{'id': order.id, 'table_number': order.table_number, 'creator_id': order.creator_id, 'creator_type': order.creator_type,
                    'order_time': order.order_time.isoformat(), 'order_type': order.order_type, 'delivery_id': order.delivery_id,
                    'total_price': str(order.total_price), 'created_at': order.created_at.isoformat(), 'updated_at': order.updated_at.isoformat()} for order in orders]
    return jsonify(orders_list), 200

@orders_bp.route('/orders/<int:id>', methods=['GET'])
def get_order(id):
    order = Order.query.get_or_404(id)
    order_details = {'id': order.id, 'table_number': order.table_number, 'creator_id': order.creator_id, 'creator_type': order.creator_type,
                     'order_time': order.order_time.isoformat(), 'order_type': order.order_type, 'delivery_id': order.delivery_id,
                     'total_price': str(order.total_price), 'created_at': order.created_at.isoformat(), 'updated_at': order.updated_at.isoformat()}
    return jsonify(order_details), 200

@orders_bp.route('/orders/<int:id>', methods=['PUT'])
def update_order(id):
    data = request.get_json()
    order = Order.query.get_or_404(id)
    for key, value in data.items():
        setattr(order, key, value)
    db.session.commit()
    return jsonify({'id': order.id, 'table_number': order.table_number, 'creator_id': order.creator_id, 'creator_type': order.creator_type,
                    'order_time': order.order_time.isoformat(), 'order_type': order.order_type, 'delivery_id': order.delivery_id,
                    'total_price': str(order.total_price), 'created_at': order.created_at.isoformat(), 'updated_at': order.updated_at.isoformat()}), 200

@orders_bp.route('/orders/<int:id>', methods=['DELETE'])
def delete_order(id):
    order = Order.query.get_or_404(id)

    # Update analytics counters (if applicable)
    order_details = OrderDetail.query.filter_by(order_id=order.id).all()
    for detail in order_details:
        analytics_record = Analytics.query.filter_by(food_item_id=detail.food_item_id).first()
        if analytics_record:
            analytics_record.counter -= 1

    db.session.delete(order)
    db.session.commit()
    return '', 204
