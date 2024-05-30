<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderProduct;
use App\Models\Product;
use Illuminate\Http\Request;
use SmoDav\Mpesa\STK;

class OrderController extends Controller
{
    public function index()
    {
        return Order::with('customer', 'products')->get();
    }

    public function store(Request $request)
    {
        $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'products' => 'required|array',
            'products.*.id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'phone' => 'required|regex:/^2547\d{8}$/', // Ensure valid Kenyan phone number
        ]);

        $totalAmount = 0;
        foreach ($request->products as $product) {
            $productModel = Product::find($product['id']);
            $totalAmount += $productModel->price * $product['quantity'];
        }

        $order = Order::create([
            'customer_id' => $request->customer_id,
            'total_amount' => $totalAmount,
            'status' => 'pending',
        ]);

        foreach ($request->products as $product) {
            OrderProduct::create([
                'order_id' => $order->id,
                'product_id' => $product['id'],
                'quantity' => $product['quantity'],
            ]);
        }

        // Handle MPesa STK Push
        try {
            $stkPush = STK::request($totalAmount)
                ->from($request->phone)
                ->usingReference($order->id)
                ->push();

            if ($stkPush['ResponseCode'] === '0') {
                $order->update(['status' => 'processing']);
            } else {
                // Handle STK push failure
                return response()->json(['error' => 'MPesa payment initiation failed'], 500);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => 'MPesa payment initiation error: ' . $e->getMessage()], 500);
        }

        return $order->load('customer', 'products');
    }

    public function show($id)
    {
        return Order::with('customer', 'products')->findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:pending,processing,completed',
        ]);

        $order = Order::findOrFail($id);
        $order->update($request->only('status'));

        return $order->load('customer', 'products');
    }

    public function destroy($id)
    {
        $order = Order::findOrFail($id);
        $order->delete();

        return response()->json(null, 204);
    }
}
