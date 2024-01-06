from flask import Blueprint, render_template, request, jsonify
import logging
from Controls.function_home import execute_query

# Настройка логирования
logging.basicConfig(level=logging.INFO)

home_bp = Blueprint('home_bp', __name__, template_folder='templates')


@home_bp.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')


@home_bp.route('/order')
def order():
    return render_template('order.html')


@home_bp.route('/create_order', methods=['POST'])
def create_order():
    try:
        order_data = request.get_json()

        if 'IdCustomer' not in order_data:
            return jsonify({"error": "IdCustomer is required"}), 400

        try:
            id_customer = int(order_data['IdCustomer'])
        except ValueError:
            return jsonify({"error": "Invalid IdCustomer"}), 400

        query = """
                INSERT INTO Orders (IdCustomer, IdRestaurant, OrderTime, DeliveryTimeForecast, IdCourier)
                VALUES (%s, %s, %s, %s, %s)
                """
        args = (
            id_customer,
            order_data['IdRestaurant'],
            order_data['OrderTime'],
            order_data['DeliveryTimeForecast'],
            order_data['IdCourier']
        )
        execute_query(query, args)
        return jsonify({"message": "Order created successfully"}), 201
    except Exception as e:
        logging.error(f"Error creating order: {e}")
        return jsonify({"error": str(e)}), 500

@home_bp.route('/orders', methods=['GET'])
def get_orders():
    try:
        query = "SELECT IdOrder, IdCustomer, IdRestaurant, OrderTime, DeliveryTimeForecast, IdCourier FROM Orders"
        orders = execute_query(query, fetch=True)
        return jsonify(orders)
    except Exception as e:
        logging.error(f"Error retrieving orders: {e}")
        return jsonify({"error": str(e)}), 500



@home_bp.route('/update_order/<order_id>', methods=['PUT'])
def update_order(order_id):
    try:
        updated_data = request.get_json()

        order_check_query = "SELECT 1 FROM Orders WHERE IdOrder = %s"
        if not execute_query(order_check_query, (order_id,), fetch=True):
            return jsonify({"error": "Order not found"}), 404

        query = """
                UPDATE Orders
                SET IdCustomer = %s, IdRestaurant = %s, OrderTime = %s, DeliveryTimeForecast = %s, IdCourier = %s
                WHERE IdOrder = %s
                """
        args = (
            updated_data['IdCustomer'],
            updated_data['IdRestaurant'],
            updated_data['OrderTime'],
            updated_data['DeliveryTimeForecast'],
            updated_data['IdCourier'],
            order_id
        )
        execute_query(query, args)
        return jsonify({"message": "Order updated successfully"})
    except Exception as e:
        logging.error(f"Error updating order: {e}")
        return jsonify({"error": str(e)}), 500


@home_bp.route('/delete_order/<order_id>', methods=['DELETE'])
def delete_order(order_id):
    try:
        order_check_query = "SELECT 1 FROM Orders WHERE IdOrder = %s"
        if not execute_query(order_check_query, (order_id,), fetch=True):
            return jsonify({"error": "Order not found"}), 404

        query = "DELETE FROM Orders WHERE IdOrder = %s"
        execute_query(query, (order_id,))
        return jsonify({"message": "Order deleted successfully"})
    except Exception as e:
        logging.error(f"Error deleting order: {e}")
        return jsonify({"error": str(e)}), 500


@home_bp.route('/get_order/<order_id>', methods=['GET'])
def get_order(order_id):
    try:
        query = "SELECT IdOrder, IdCustomer, IdRestaurant, OrderTime, DeliveryTimeForecast, IdCourier FROM Orders WHERE IdOrder = %s"
        order = execute_query(query, (order_id,), fetch=True)
        if not order:
            return jsonify({"error": "Order not found"}), 404
        return jsonify(order[0])
    except Exception as e:
        logging.error(f"Error retrieving order: {e}")
        return jsonify({"error": str(e)}), 500
