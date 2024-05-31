<!DOCTYPE html>
<html>
<head>
    <title>Order Status Changed</title>
</head>
<body>
    <h1>Order Status Update</h1>
    <p>Dear {{ $order->customer->name }},</p>
    <p>Your order with ID {{ $order->id }} has been updated to "{{ $order->status }}".</p>
    <p>Thank you for shopping with us!</p>
</body>
</html>
