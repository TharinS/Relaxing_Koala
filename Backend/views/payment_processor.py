from flask import Blueprint, request, jsonify
from app import db
from models.delivery import Delivery
from models.order import Order
from models.order_detail import OrderDetail
from models.transaction import Transaction
from models.analytics import Analytics

payment_processor_bp = Blueprint('payment_processor', __name__)

@payment_processor_bp.route('/process_payment', methods=['POST'])
def process_payment():
    data = request.get_json()

    # Create delivery entry if order type is delivery
    delivery_id = None
    if data['order_type'] == 'delivery':
        delivery_data = data['delivery']
        new_delivery = Delivery(
            address=delivery_data['address'],
            state=delivery_data['state'],
            postcode=delivery_data['postcode'],
            delivery_time=delivery_data['delivery_time']
        )
        db.session.add(new_delivery)
        db.session.commit()
        delivery_id = new_delivery.id

    # Create order
    new_order = Order(
        table_number=data.get('table_number'),
        creator_id=data['creator_id'],
        creator_type=data['creator_type'],
        order_time=data['order_time'],
        order_type=data['order_type'],
        delivery_id=delivery_id,
        total_price=data['total_price']
    )
    db.session.add(new_order)
    db.session.commit()

    # Create order details
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

    # Create transaction
    new_transaction = Transaction(
        user_id=data['creator_id'],
        order_id=new_order.id,
        transaction_type=data['payment_mode'],
        amount=data['total_price']
    )
    db.session.add(new_transaction)
    db.session.commit()

    return jsonify({
        'order_id': new_order.id,
        'delivery_id': delivery_id,
        'transaction_id': new_transaction.id
    }), 201
