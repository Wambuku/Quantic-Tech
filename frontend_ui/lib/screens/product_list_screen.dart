import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addProduct');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: productProvider.fetchProducts(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = productProvider.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                final product = products[i];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await productProvider.deleteProduct(product.id);
                      // Refresh the list or handle state
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/editProduct', arguments: product);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
