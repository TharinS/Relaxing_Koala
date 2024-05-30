from app import db
from models.user import User
from models.order import Order
from models.order_detail import OrderDetail
from models.delivery import Delivery
from models.transaction import Transaction
import datetime

def process_payment(user_details, order_details, payment_details):
    try:
        print(user_details)
        print(order_details)
        print(payment_details)

        return {'message': 'Payment processed successfully'}, None
    except Exception as e:
        db.session.rollback()
        return None, str(e)
