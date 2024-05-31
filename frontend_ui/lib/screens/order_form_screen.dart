import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../providers/order_provider.dart';

class OrderFormScreen extends StatefulWidget {
  final Order? order;

  OrderFormScreen({this.order});

  @override
  _OrderFormScreenState createState() => _OrderFormScreenState();
}

class _OrderFormScreenState extends State<OrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _customerId;
  late String _status;
  late List<OrderItem> _products;

  @override
  void initState() {
    super.initState();
    if (widget.order != null) {
      _customerId = widget.order!.customerId;
      _status = widget.order!.status;
      _products = widget.order!.products;
    } else {
      _customerId = 0;
      _status = 'pending';
      _products = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order == null ? 'Add Order' : 'Edit Order'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _customerId.toString(),
                decoration: InputDecoration(labelText: 'Customer ID'),
                onSaved: (value) {
                  _customerId = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a customer ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _status,
                decoration: InputDecoration(labelText: 'Status'),
                onSaved: (value) {
                  _status = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a status';
                  }
                  return null;
                },
              ),
              // Add form fields for order items as needed
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Order newOrder = Order(
                      id: widget.order?.id ?? 0,
                      customerId: _customerId,
                      products: _products,
                      status: _status,
                    );
                    if (widget.order == null) {
                      Provider.of<OrderProvider>(context, listen: false).addOrder(newOrder);
                    } else {
                      Provider.of<OrderProvider>(context, listen: false).updateOrder(newOrder);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
