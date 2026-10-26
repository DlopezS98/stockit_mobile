import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/data/models/user_model.dart';
import 'package:stockit_mobile/presentation/providers/auth_provider.dart';
import 'package:stockit_mobile/presentation/providers/user_provider.dart';
import 'package:stockit_mobile/presentation/widgets/error_view.dart';
import 'package:stockit_mobile/presentation/widgets/loading_view.dart';
part 'widgets/user_list.dart';
part 'widgets/user_avatar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
        actions: [
          _CurrentUserAvatar(),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: context.read<AuthProvider>().logout,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16.0),
            const Expanded(child: _UserList()),
          ],
        ),
      ),
    );
  }
}
