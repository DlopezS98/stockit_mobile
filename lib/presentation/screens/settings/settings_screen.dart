import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/widgets/main_layout.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // TODO: persist these once preferences are backed by storage.
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Settings',
      child: ListView(
        children: [
          const _SectionHeader('Preferences'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            value: _notificationsEnabled,
            onChanged: (value) => setState(() => _notificationsEnabled = value),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark mode'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          const Divider(),
          const _SectionHeader('About'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version'),
            subtitle: Text('1.0.0'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log out', style: TextStyle(color: Colors.red)),
            onTap: context.read<AuthProvider>().logout,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
