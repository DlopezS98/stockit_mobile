part of '../register_screen.dart';

class _RoleField extends StatelessWidget {
  const _RoleField();

  @override
  Widget build(BuildContext context) {
    ViewStatus status = context.select<RolesProvider, ViewStatus>(
      (provider) => provider.viewStatus,
    );
    switch (status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        return const InputDecorator(
          decoration: InputDecoration(
            labelText: 'Role',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.badge_outlined),
          ),
          child: Center(child: CircularProgressIndicator()),
        );
      case ViewStatus.success:
        final roles = context.select<RolesProvider, List<RoleModel>>(
          (provider) => provider.roles,
        );
        return DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            labelText: 'Role',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.badge_outlined),
          ),
          items: [
            for (var role in roles)
              DropdownMenuItem<int>(value: role.id, child: Text(role.name)),
          ],
          onChanged: (value) {},
          validator: (value) => value == null ? 'Please select a role' : null,
        );
      case ViewStatus.error:
        final errorMessage = context.select<RolesProvider, String?>(
          (provider) => provider.errorMessage,
        );
        return Text('Error loading roles: $errorMessage');
    }
  }
}
