import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';

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
      body: SafeArea(child: child),
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
