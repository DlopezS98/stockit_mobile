import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/counter_notifier.dart';

void main() {
  runApp(const StockitApp());
}

class StockitApp extends StatelessWidget {
  const StockitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      home: ChangeNotifierProvider(
        create: (context) => CounterNotifier(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter App")),
      body: Consumer<CounterNotifier>(
        builder: (context, counterNotifier, child) {
          return Center(
            child: Text(
              'Counter: ${counterNotifier.counter}',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: context.read<CounterNotifier>().incrementCounter,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: context.read<CounterNotifier>().decrementCounter,
            child: Icon(Icons.remove),
          ),
        ],
      )
    );
  }
}