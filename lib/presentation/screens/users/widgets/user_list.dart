part of '../user_screen.dart';

class _UserList extends StatelessWidget {
  const _UserList();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    switch (userProvider.viewStatus) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return LoadingView(message: 'Loading users...');
      case ViewStatus.error:
        return ErrorView(
          errorMessage: userProvider.errorMessage ?? 'Unknown error',
          onRetry: () => userProvider.fetchUsers(),
        );
      case ViewStatus.success:
        if (userProvider.users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }
        return RefreshIndicator(
          onRefresh: () => userProvider.fetchUsers(),
          child: ListView.builder(
            itemCount: userProvider.users.length,
            itemBuilder: (context, index) {
              final user = userProvider.users[index];
              return ListTile(
                title: Text(user.fullName),
                subtitle: Text(user.email),
              );
            },
          ),
        );
    }
  }
}
