import 'package:flutter/material.dart';

void main() {
  runApp(const StockitApp());
}

class StockitApp extends StatelessWidget {
  const StockitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      home: Center(
        child: Text("Welcome to the Flutter App"),
      ),
    );
  }
}