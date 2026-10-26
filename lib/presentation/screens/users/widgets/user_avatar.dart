part of '../user_screen.dart';

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
          child: Text(user.fullName.isEmpty ? '?' : user.fullName[0].toUpperCase()),
        ),
      ),
    );
  }
}