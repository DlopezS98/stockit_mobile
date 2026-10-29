import 'package:flutter/material.dart';
import 'package:stockit_mobile/presentation/widgets/error_view.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not found')),
      body: ErrorView(errorMessage: 'No page found for "${routeName ?? ''}".'),
    );
  }
}