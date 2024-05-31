import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order.dart';

class OrderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addOrder');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = orderProvider.orders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) {
                final order = orders[i];
                return ListTile(
                  title: Text('Order ${order.id}'),
                  subtitle: Text('Status: ${order.status}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await orderProvider.deleteOrder(order.id);
                      // Refresh the list or handle state
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/editOrder', arguments: order);
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
