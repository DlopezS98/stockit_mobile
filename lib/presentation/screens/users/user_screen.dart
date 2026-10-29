import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit_mobile/core/constants/view_status.dart';
import 'package:stockit_mobile/presentation/providers/user_provider.dart';
import 'package:stockit_mobile/presentation/widgets/error_view.dart';
import 'package:stockit_mobile/presentation/widgets/loading_view.dart';
import 'package:stockit_mobile/presentation/widgets/main_layout.dart';
part 'widgets/user_list.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'User Screen',
      child: Padding(
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
