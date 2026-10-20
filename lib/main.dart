import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();

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