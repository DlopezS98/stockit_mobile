import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/widgets/main_layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthProvider, UserModel?>(
      (auth) => auth.currentUser,
    );

    return MainLayout(
      title: 'Profile',
      child: user == null
          ? const Center(child: Text('No user information available.'))
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      user.fullName.isEmpty
                          ? '?'
                          : user.fullName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user.fullName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.alternate_email),
                        title: const Text('Username'),
                        subtitle: Text(user.username),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(user.email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.badge),
                        title: const Text('Role'),
                        subtitle: Text(user.roleName),
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: const Text('Member since'),
                        subtitle: Text(
                          MaterialLocalizations.of(
                            context,
                          ).formatMediumDate(user.createdAt),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
