import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/core/di/injection.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/providers/user_provider.dart';
import 'package:stockit_mobile/presentation/routes/app_routes.dart';
import 'package:stockit_mobile/presentation/screens/login/login_screen.dart';
import 'package:stockit_mobile/presentation/screens/not_found/not_found_screen.dart';
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

class StockitApp extends StatefulWidget {
  const StockitApp({super.key});

  @override
  State<StockitApp> createState() => _StockitAppState();
}

class _StockitAppState extends State<StockitApp> {
  final AuthProvider _authProvider = getIt<AuthProvider>();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<AuthProvider>().checkSession();
    // });
    _authProvider.addListener(_onAuthChange);
  }

  void _onAuthChange() {
    final authStatus = _authProvider.authStatus;
    if (authStatus == AuthStatus.unknown) return;

    debugPrint('Auth status changed: $authStatus');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      initialRoute: AppRoutes.splash,
      routes: {
        '/splash': (context) =>
            Scaffold(body: const Center(child: CircularProgressIndicator())),
        '/login': (context) => const LoginScreen(),
        '/users': (context) => ChangeNotifierProvider(
          create: (_) => getIt<UserProvider>()..fetchUsers(),
          child: const UserScreen(),
        ),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const NotFoundPage(),
        settings: settings,
      ),
    );
  }
}
