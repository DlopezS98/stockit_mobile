import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/routes/app_routes.dart';
import 'package:stockit_mobile/presentation/widgets/main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fullName = context.select<AuthProvider, String?>(
      (auth) => auth.currentUser?.fullName,
    );

    return MainLayout(
      title: 'Home',
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            fullName == null ? 'Welcome' : 'Welcome, $fullName',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: const [
              _HomeTile(
                icon: Icons.people,
                label: 'Users',
                route: AppRoutes.users,
              ),
              _HomeTile(
                icon: Icons.person,
                label: 'Profile',
                route: AppRoutes.profile,
              ),
              _HomeTile(
                icon: Icons.settings,
                label: 'Settings',
                route: AppRoutes.settings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  const _HomeTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pushReplacementNamed(route),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
