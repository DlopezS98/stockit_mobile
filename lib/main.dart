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
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AuthProvider _authProvider = getIt<AuthProvider>();
  AuthStatus _routedStatus = AuthStatus.unknown;

  @override
  void initState() {
    super.initState();
    _authProvider.addListener(_onAuthChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onAuthChange();
    });
  }

  void _onAuthChange() {
    AuthStatus authStatus = _authProvider.authStatus;
    NavigatorState? navigator = _navigatorKey.currentState;
    if (authStatus == _routedStatus || navigator == null) return;

    _routedStatus = authStatus;

    final route = switch (authStatus) {
      AuthStatus.authenticated => AppRoutes.users,
      AuthStatus.unauthenticated => AppRoutes.login,
      AuthStatus.unknown => AppRoutes.splash,
    };

    navigator.pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  void dispose() {
    _authProvider.removeListener(_onAuthChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'My First Flutter Application',
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) =>
            Scaffold(body: const Center(child: CircularProgressIndicator())),
        AppRoutes.login: (context) => Scaffold(body: const LoginScreen()),
        AppRoutes.users: (context) => ChangeNotifierProvider(
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
