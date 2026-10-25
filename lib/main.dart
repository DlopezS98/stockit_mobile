import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/core/di/injection.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/screens/login/login_screen.dart';

Future<void> main() async {
  await dotenv.load();
  setupDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (_) => getIt<AuthProvider>(),
      child: const StockitApp(),
    ),
  );
}

class StockitApp extends StatelessWidget {
  const StockitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      home: Scaffold(
        body: const Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
