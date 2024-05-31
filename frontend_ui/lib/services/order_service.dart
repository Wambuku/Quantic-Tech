import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';

class OrderService {
  static const String _baseUrl = 'http://localhost:8000/api/orders';

  static Future<List<Order>> getOrders(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Order.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  static Future<Order> createOrder(Order order, String token) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(order.toJson()),
    );
    if (response.statusCode == 201) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  static Future<void> updateOrder(Order order, String token) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${order.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(order.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update order');
    }
  }

  static Future<void> deleteOrder(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete order');
    }
  }
}
