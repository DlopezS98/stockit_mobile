import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/routes/app_routes.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget child;
  const MainLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          _CurrentUserAvatar(),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: context.read<AuthProvider>().logout,
          ),
        ],
      ),
      drawer: const _NavigationDrawer(),
      body: SafeArea(child: child),
    );
  }
}

class _NavigationDrawer extends StatelessWidget {
  const _NavigationDrawer();

  static const _destinations = [
    (icon: Icons.home, label: 'Home', route: AppRoutes.home),
    (icon: Icons.people, label: 'Users', route: AppRoutes.users),
    (icon: Icons.person, label: 'Profile', route: AppRoutes.profile),
    (icon: Icons.settings, label: 'Settings', route: AppRoutes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Row(
                children: [
                  Icon(Icons.inventory_2, size: 40),
                  SizedBox(width: 12),
                  Text('Stockit', style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
            for (final destination in _destinations)
              ListTile(
                leading: Icon(destination.icon),
                title: Text(destination.label),
                selected: destination.route == currentRoute,
                onTap: () {
                  Navigator.of(context).pop();
                  if (destination.route != currentRoute) {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(destination.route);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _CurrentUserAvatar extends StatelessWidget {
  const _CurrentUserAvatar();

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthProvider, UserModel?>(
      (auth) => auth.currentUser,
    );
    if (user == null) return const SizedBox.shrink();

    return Tooltip(
      message: 'Signed in as ${user.fullName}\n${user.email}',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CircleAvatar(
          radius: 16,
          child: Text(
            user.fullName.isEmpty ? '?' : user.fullName[0].toUpperCase(),
          ),
        ),
      ),
    );
  }
}
