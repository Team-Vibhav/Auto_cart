import 'package:auto_cart_app/controllers/qrcode_scanner.dart';
import 'package:auto_cart_app/home.dart';
import 'package:flutter/material.dart';
import 'add_to_cart.dart';
// import 'home.dart';
import 'payment_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Color(0xFFF5DFDC),
          ),
      routes: {
        '/': (context) => HomePage(),
        '/qrcodescanner': (context) => QRcodeScanner(),
        '/paymentpage': (context) => PaymentPage(),
        '/addtocart': (context) => AddToCart(),
      },
    );
  }
}
