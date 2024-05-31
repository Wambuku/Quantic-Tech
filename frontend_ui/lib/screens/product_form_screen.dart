import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  ProductFormScreen({this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _description;
  late double _price;
  late int _quantity;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _description = widget.product!.description;
      _price = widget.product!.price;
      _quantity = widget.product!.quantity;
    } else {
      _name = '';
      _description = '';
      _price = 0.0;
      _quantity = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
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
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = double.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _quantity.toString(),
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _quantity = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a quantity';
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
                    Product newProduct = Product(
                      id: widget.product?.id ?? 0,
                      name: _name,
                      description: _description,
                      price: _price,
                      quantity: _quantity,
                    );
                    if (widget.product == null) {
                      Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);
                    } else {
                      Provider.of<ProductProvider>(context, listen: false).updateProduct(newProduct);
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
