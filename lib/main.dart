import 'package:flutter/material.dart';
import 'package:flutter_laravel_test/screens/home_screen.dart';
import 'package:flutter_laravel_test/utils/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sanctum FoodDelivery',
      home: HomeScreen(),
    );
  }
}
