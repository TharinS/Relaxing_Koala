from models.user import User
from models.order import Order
from models.order_detail import OrderDetail
from models.food_item import FoodItem
from models.delivery import Delivery  

def generate_receipt(receiver_id, user_id, order_id):
    user = User.query.get(user_id)
    order = Order.query.get(order_id)

    if not user or not order:
        return None, "User or Order not found."

    receipt = {
        'receiver_id': receiver_id,
        'user_id': user_id,
        'order_id': order_id,
        'order_type': order.order_type,
        'order_time': order.order_time,
        'items': [],
        'total_price': float(order.total_price),
    }

    if order.order_type == 'delivery':
        delivery = Delivery.query.get(order.delivery_id)  
        if delivery:
            receipt['delivery_address'] = f"{delivery.address}, {delivery.state}, {delivery.postcode}"
            receipt['delivery_charge'] = 5.0
            receipt['total_price'] += 5.0
    else:
        receipt['table_number'] = order.table_number

    order_details = OrderDetail.query.filter_by(order_id=order_id).all()
    for detail in order_details:
        food_item = FoodItem.query.get(detail.food_item_id)
        if food_item:
            receipt['items'].append({
                'name': food_item.foodname,
                'price': float(detail.price),
                'quantity': detail.quantity,
                'total': float(detail.price) * detail.quantity
            })

    return receipt, None
