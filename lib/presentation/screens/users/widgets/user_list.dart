part of '../user_screen.dart';

class _UserList extends StatelessWidget {
  const _UserList();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    switch (userProvider.viewStatus) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Loading users...'),
            ],
          ),
        );
      case ViewStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48.0),
                Text(
                  'Error: ${userProvider.errorMessage}',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    userProvider.fetchUsers();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      case ViewStatus.success:
        if (userProvider.users.isEmpty) {
          return const Center(child: Text('No users found.'));
        }
        return ListView.builder(
          itemCount: userProvider.users.length,
          itemBuilder: (context, index) {
            final user = userProvider.users[index];
            return ListTile(
              title: Text(user.fullName),
              subtitle: Text(user.email),
            );
          },
        );
    }
  }
}
