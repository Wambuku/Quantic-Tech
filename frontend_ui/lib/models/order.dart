class Order {
  final int id;
  final int customerId;
  final List<OrderItem> products;
  final String status;

  Order({
    required this.id,
    required this.customerId,
    required this.products,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customer_id'],
      products: (json['products'] as List)
          .map((i) => OrderItem.fromJson(i))
          .toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'products': products.map((p) => p.toJson()).toList(),
      'status': status,
    };
  }
}

class OrderItem {
  final int id;
  final int quantity;

  OrderItem({required this.id, required this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
