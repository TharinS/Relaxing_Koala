from flask import Blueprint, request, jsonify, send_from_directory, current_app
from app import db
from models.food_item import FoodItem
from controllers.food_item import retrieve_filename

food_items_bp = Blueprint('food_items', __name__)

@food_items_bp.route('/food_items', methods=['POST'])
def create_food_item():
    data = request.get_json()
    new_food_item = FoodItem(
        foodname=data['foodname'],
        price=data['price'],
        description=data.get('description'),
        category=data.get('category'),
        available=data.get('available', True),
        asset=data.get('asset')
    )
    db.session.add(new_food_item)
    db.session.commit()
    return jsonify({'id': new_food_item.id}), 201

@food_items_bp.route('/food_items', methods=['GET'])
def get_food_items():
    food_items = FoodItem.query.all()
    return jsonify([item.to_dict() for item in food_items]), 200

@food_items_bp.route('/food_items/<int:id>', methods=['GET'])
def get_food_item(id):
    food_item = FoodItem.query.get_or_404(id)
    return jsonify(food_item.to_dict()), 200

@food_items_bp.route('/food_items/<int:id>', methods=['PUT'])
def update_food_item(id):
    data = request.get_json()
    food_item = FoodItem.query.get_or_404(id)
    for key, value in data.items():
        setattr(food_item, key, value)
    db.session.commit()
    return jsonify(food_item.to_dict()), 200

@food_items_bp.route('/food_items/<int:id>', methods=['DELETE'])
def delete_food_item(id):
    food_item = FoodItem.query.get_or_404(id)
    db.session.delete(food_item)
    db.session.commit()
    return '', 204

@food_items_bp.route('/food_items/asset/<int:id>', methods=['GET'])
def get_food_item_asset(id):
    food_item = FoodItem.query.get_or_404(id)
    asset_folder = current_app.config['UPLOAD_FOLDER']
    asset_filename = retrieve_filename(asset_folder, food_item.asset)
    
    if not asset_filename:
        return jsonify({'message': 'No asset found for this food item'}), 404
    return send_from_directory(asset_folder, asset_filename)