import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/core/di/injection.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/providers/user_provider.dart';
import 'package:stockit_mobile/presentation/screens/login/login_screen.dart';
import 'package:stockit_mobile/presentation/screens/users/user_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  setupDependencies();

  getIt<AuthProvider>().checkSession();

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
      home: Scaffold(body: _AuthGuard()),
    );
  }
}

class _AuthGuard extends StatelessWidget {
  const _AuthGuard();

  @override
  Widget build(BuildContext context) {
    // Splash screens
    var authProvider = context.watch<AuthProvider>();
    switch (authProvider.authStatus) {
      case AuthStatus.authenticated:
        return ChangeNotifierProvider(
          create: (_) => getIt<UserProvider>()..fetchUsers(),
          child: const UserScreen(),
        );
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      // case AuthStatus.unknown:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
