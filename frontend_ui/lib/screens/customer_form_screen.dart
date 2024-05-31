import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';

class CustomerFormScreen extends StatefulWidget {
  final Customer? customer;

  CustomerFormScreen({this.customer});

  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _email, _phone, _address;

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _name = widget.customer!.name;
      _email = widget.customer!.email;
      _phone = widget.customer!.phone;
      _address = widget.customer!.address;
    } else {
      _name = '';
      _email = '';
      _phone = '';
      _address = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  _email = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) {
                  _phone = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: 'Address'),
                onSaved: (value) {
                  _address = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Customer newCustomer = Customer(
                      id: widget.customer?.id ?? 0,
                      name: _name,
                      email: _email,
                      phone: _phone,
                      address: _address,
                    );
                    if (widget.customer == null) {
                      Provider.of<CustomerProvider>(context, listen: false).addCustomer(newCustomer);
                    } else {
                      Provider.of<CustomerProvider>(context, listen: false).updateCustomer(newCustomer);
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
