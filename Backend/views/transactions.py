from flask import Blueprint, request, jsonify
from app import db
from models.transaction import Transaction

transactions_bp = Blueprint('transactions', __name__)

@transactions_bp.route('/transactions', methods=['POST'])
def create_transaction():
    data = request.get_json()
    new_transaction = Transaction(
        user_id=data['user_id'],
        order_id=data['order_id'],
        transaction_type=data['transaction_type'],
        transaction_time=data['transaction_time'],
        amount=data['amount']
    )
    db.session.add(new_transaction)
    db.session.commit()
    return jsonify({'id': new_transaction.id}), 201

@transactions_bp.route('/transactions', methods=['GET'])
def get_transactions():
    transactions = Transaction.query.all()
    return jsonify([transaction.__dict__ for transaction in transactions]), 200

@transactions_bp.route('/transactions/<int:id>', methods=['GET'])
def get_transaction(id):
    transaction = Transaction.query.get_or_404(id)
    return jsonify(transaction.__dict__), 200

@transactions_bp.route('/transactions/<int:id>', methods=['PUT'])
def update_transaction(id):
    data = request.get_json()
    transaction = Transaction.query.get_or_404(id)
    for key, value in data.items():
        setattr(transaction, key, value)
    db.session.commit()
    return jsonify(transaction.__dict__), 200

@transactions_bp.route('/transactions/<int:id>', methods=['DELETE'])
def delete_transaction(id):
    transaction = Transaction.query.get_or_404(id)
    db.session.delete(transaction)
    db.session.commit()
    return '', 204
