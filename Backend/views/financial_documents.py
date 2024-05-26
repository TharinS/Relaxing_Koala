from flask import Blueprint, request, jsonify
from controllers.financial_document import generate_receipt

financial_document_bp = Blueprint('financial_document', __name__)

@financial_document_bp.route('/financial_document/receipt', methods=['POST'])
def receipt():
    data = request.get_json()
    receiver_id = data.get('receiver_id')
    user_id = data.get('user_id')
    order_id = data.get('order_id')

    if not receiver_id or not user_id or not order_id:
        return jsonify({'message': 'receiver_id, user_id, and order_id are required'}), 400

    receipt, error = generate_receipt(receiver_id, user_id, order_id)

    if error:
        return jsonify({'message': error}), 404

    return jsonify(receipt), 200
