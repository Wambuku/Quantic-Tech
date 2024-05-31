import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];
  String _token = '';

  List<Customer> get customers => _customers;

  set token(String token) {
    _token = token;
  }

  Future<void> fetchCustomers() async {
    _customers = await CustomerService.getCustomers(_token);
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    final newCustomer = await CustomerService.createCustomer(customer, _token);
    _customers.add(newCustomer);
    notifyListeners();
  }

  Future<void> updateCustomer(Customer customer) async {
    await CustomerService.updateCustomer(customer, _token);
    final index = _customers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _customers[index] = customer;
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(int id) async {
    await CustomerService.deleteCustomer(id, _token);
    _customers.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
