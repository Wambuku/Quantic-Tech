import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/customer_provider.dart';
import 'providers/product_provider.dart';
import 'providers/order_provider.dart';
import 'screens/customer_list_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/order_list_screen.dart';
import 'screens/customer_form_screen.dart';
import 'screens/product_form_screen.dart';
import 'screens/order_form_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Customer Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
        routes: {
          '/login': (ctx) => LoginScreen(),
          '/home': (ctx) => HomeScreen(),
          '/customers': (ctx) => CustomerListScreen(),
          '/addCustomer': (ctx) => CustomerFormScreen(),
          '/editCustomer': (ctx) => CustomerFormScreen(),
          '/products': (ctx) => ProductListScreen(),
          '/addProduct': (ctx) => ProductFormScreen(),
          '/editProduct': (ctx) => ProductFormScreen(),
          '/orders': (ctx) => OrderListScreen(),
          '/addOrder': (ctx) => OrderFormScreen(),
          '/editOrder': (ctx) => OrderFormScreen(),
        },
      ),
    );
  }
}
