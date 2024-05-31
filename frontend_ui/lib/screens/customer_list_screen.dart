import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import '../models/customer.dart';

class CustomerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addCustomer');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: customerProvider.fetchCustomers(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final customers = customerProvider.customers;
            return ListView.builder(
              itemCount: customers.length,
              itemBuilder: (ctx, i) {
                final customer = customers[i];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.email),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await customerProvider.deleteCustomer(customer.id);
                      // Refresh the list or handle state
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/editCustomer', arguments: customer);
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
