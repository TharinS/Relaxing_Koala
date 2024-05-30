def register_blueprints(app):
    from .users import users_bp
    from .food_items import food_items_bp
    from .reservations import reservations_bp
    from .deliveries import deliveries_bp
    from .analytics import analytics_bp
    from .orders import orders_bp
    from .order_details import order_details_bp
    from .transactions import transactions_bp
    from .financial_documents import financial_document_bp
    from views.payment_processor import payment_processor_bp

    app.register_blueprint(users_bp)
    app.register_blueprint(food_items_bp)
    app.register_blueprint(reservations_bp)
    app.register_blueprint(deliveries_bp)
    app.register_blueprint(analytics_bp)
    app.register_blueprint(orders_bp)
    app.register_blueprint(order_details_bp)
    app.register_blueprint(transactions_bp)
    app.register_blueprint(financial_document_bp)
    app.register_blueprint(payment_processor_bp)
