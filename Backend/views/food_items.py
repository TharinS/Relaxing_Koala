from flask import Blueprint, request, jsonify
from app import db
from models.food_item import FoodItem

food_items_bp = Blueprint('food_items', __name__)

@food_items_bp.route('/food_items', methods=['POST'])
def create_food_item():
    data = request.get_json()
    new_food_item = FoodItem(**data)
    db.session.add(new_food_item)
    db.session.commit()
    return jsonify({'id': new_food_item.id}), 201

@food_items_bp.route('/food_items', methods=['GET'])
def get_food_items():
    food_items = FoodItem.query.all()
    return jsonify([item.__dict__ for item in food_items]), 200

@food_items_bp.route('/food_items/<int:id>', methods=['GET'])
def get_food_item(id):
    food_item = FoodItem.query.get_or_404(id)
    return jsonify(food_item.__dict__), 200

@food_items_bp.route('/food_items/<int:id>', methods=['PUT'])
def update_food_item(id):
    data = request.get_json()
    food_item = FoodItem.query.get_or_404(id)
    for key, value in data.items():
        setattr(food_item, key, value)
    db.session.commit()
    return jsonify(food_item.__dict__), 200

@food_items_bp.route('/food_items/<int:id>', methods=['DELETE'])
def delete_food_item(id):
    food_item = FoodItem.query.get_or_404(id)
    db.session.delete(food_item)
    db.session.commit()
    return '', 204
