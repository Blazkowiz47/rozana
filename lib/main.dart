import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rozana/screens/authenticate/location.dart';
import 'package:rozana/screens/authenticate/login.dart';
import 'package:rozana/screens/authenticate/passwordReset.dart';
import 'package:rozana/screens/authenticate/register.dart';
import 'package:rozana/screens/home/homepage.dart';
import 'package:rozana/theme.dart';
import 'model/models.dart';

List<String> categories = [
  "Face Masks",
  "Beverages",
  "Chocolates",
  "Food grains Oil & Masalas",
  "Bakery, Cakes & Dairy",
  "Egg, Meat & Fish",
  "Pet Food",
  "Beauty & Hygiene",
  "Snacks & Branded Food",
  "Cleaning & Household",
  "Baby Care",
  "Gourment & World Food",
  "Stationary Items",
  "Gifts",
  "Body Care"
];
List<Product> cart = [];
List<OffersModel> offersGlobalList = [];
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login' : (context) => Login(),
        '/register' : (context) => Register(),
        '/register/location' : (context) => GetLocation(),
        '/login/forgotPassword' : (context) => ForgotPassword(),
        '/' : (context) => HomePage(),
      },
      theme: myTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
