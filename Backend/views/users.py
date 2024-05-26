from flask import Blueprint, request, jsonify
from flask_login import login_user, logout_user, login_required
from app import db
from models.user import User

users_bp = Blueprint('users', __name__)

@users_bp.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    new_user = User(
        first_name=data['first_name'],
        last_name=data['last_name'],
        email=data['email'],
        password=data['password'],
        address=data.get('address'),
        state=data.get('state'),
        postcode=data.get('postcode'),
        type=data['type']
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({'id': new_user.id}), 201

@users_bp.route('/users/login', methods=['POST'])
def login_user():
    data = request.get_json()
    user = User.query.filter_by(email=data['email']).first()
    if user and user.password == data['password']:
        login_user(user)
        return jsonify({'message': 'Login successful'}), 200
    return jsonify({'message': 'Invalid credentials'}), 401

@users_bp.route('/users/logout', methods=['POST'])
@login_required
def logout_user():
    logout_user()
    return jsonify({'message': 'Logout successful'}), 200

@users_bp.route('/users', methods=['GET'])
def get_users():
    users = User.query.all()
    return jsonify([user.__dict__ for user in users]), 200

@users_bp.route('/users/<int:id>', methods=['GET'])
@login_required
def get_user(id):
    user = User.query.get_or_404(id)
    return jsonify(user.__dict__), 200

@users_bp.route('/users/<int:id>', methods=['PUT'])
@login_required
def update_user(id):
    data = request.get_json()
    user = User.query.get_or_404(id)
    for key, value in data.items():
        setattr(user, key, value)
    db.session.commit()
    return jsonify(user.__dict__), 200

@users_bp.route('/users/<int:id>', methods=['DELETE'])
@login_required
def delete_user(id):
    user = User.query.get_or_404(id)
    db.session.delete(user)
    db.session.commit()
    return '', 204
