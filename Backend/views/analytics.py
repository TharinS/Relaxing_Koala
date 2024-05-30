from flask import Blueprint, jsonify
from app import db
from models.food_item import FoodItem
from models.analytics import Analytics
import random

analytics_bp = Blueprint('analytics', __name__)

@analytics_bp.route('/analytics/most_popular', methods=['GET'])
def most_popular():
    most_popular_item = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.desc()).first()
    if most_popular_item:
        return jsonify(most_popular_item.to_dict()), 200
    return jsonify({'message': 'No data available'}), 404

@analytics_bp.route('/analytics/least_popular', methods=['GET'])
def least_popular():
    least_popular_item = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.asc()).first()
    if least_popular_item:
        return jsonify(least_popular_item.to_dict()), 200
    return jsonify({'message': 'No data available'}), 404

@analytics_bp.route('/analytics/top_10', methods=['GET'])
def top_10():
    top_10_items = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.desc()).limit(10).all()
    return jsonify([item.to_dict() for item in top_10_items]), 200

@analytics_bp.route('/analytics/bottom_10', methods=['GET'])
def bottom_10():
    bottom_10_items = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.asc()).limit(10).all()
    return jsonify([item.to_dict() for item in bottom_10_items]), 200

@analytics_bp.route('/analytics/all_descending', methods=['GET'])
def all_descending():
    all_items_descending = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.desc()).all()
    return jsonify([item.to_dict() for item in all_items_descending]), 200

@analytics_bp.route('/analytics/all_ascending', methods=['GET'])
def all_ascending():
    all_items_ascending = db.session.query(FoodItem).join(Analytics).order_by(Analytics.counter.asc()).all()
    return jsonify([item.to_dict() for item in all_items_ascending]), 200

@analytics_bp.route('/analytics/random_recommendation', methods=['GET'])
def random_recommendation():
    all_items = db.session.query(FoodItem).all()
    if not all_items:
        return jsonify({'message': 'No food items available'}), 404
    random_item = random.choice(all_items)
    return jsonify(random_item.to_dict()), 200