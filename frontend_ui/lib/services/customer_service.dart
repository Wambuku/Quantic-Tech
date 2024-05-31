import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class CustomerService {
  static const String _baseUrl = 'http://localhost:8000/api/customers';

  static Future<List<Customer>> getCustomers(String token) async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Customer.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

  static Future<Customer> createCustomer(Customer customer, String token) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(customer.toJson()),
    );
    if (response.statusCode == 201) {
      return Customer.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create customer');
    }
  }

  static Future<void> updateCustomer(Customer customer, String token) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${customer.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(customer.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update customer');
    }
  }

  static Future<void> deleteCustomer(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete customer');
    }
  }
}
