<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\Product;
use App\Models\Customer;
use Carbon\Carbon;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        // Total sales
        $totalSales = Order::sum('total_amount');

        // Total orders
        $totalOrders = Order::count();

        // Total customers
        $totalCustomers = Customer::count();

        // Top selling products
        $topSellingProducts = Product::withCount('orders')
            ->orderBy('orders_count', 'desc')
            ->take(5)
            ->get();

        // Recent orders
        $recentOrders = Order::with('customer')
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get();

        // Sales in the last 7 days
        $salesLast7Days = Order::where('created_at', '>=', Carbon::now()->subDays(7))
            ->sum('total_amount');

        return response()->json([
            'total_sales' => $totalSales,
            'total_orders' => $totalOrders,
            'total_customers' => $totalCustomers,
            'top_selling_products' => $topSellingProducts,
            'recent_orders' => $recentOrders,
            'sales_last_7_days' => $salesLast7Days,
        ]);
    }
}