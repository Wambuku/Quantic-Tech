import 'package:flutter/material.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  String _token = '';

  List<Order> get orders => _orders;

  set token(String token) {
    _token = token;
  }

  Future<void> fetchOrders() async {
    _orders = await OrderService.getOrders(_token);
    notifyListeners();
  }

  Future<void> addOrder(Order order) async {
    final newOrder = await OrderService.createOrder(order, _token);
    _orders.add(newOrder);
    notifyListeners();
  }

  Future<void> updateOrder(Order order) async {
    await OrderService.updateOrder(order, _token);
    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index != -1) {
      _orders[index] = order;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(int id) async {
    await OrderService.deleteOrder(id, _token);
    _orders.removeWhere((o) => o.id == id);
    notifyListeners();
  }
}
