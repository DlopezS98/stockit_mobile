class RoleModel {
  final int id;
  final String name;
  final String? description;
  final List<String> permissions;

  const RoleModel({
    required this.id,
    required this.name,
    this.description,
    required this.permissions,
  });

  static RoleModel fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      permissions: List<String>.unmodifiable(
        (json['permissions'] as List? ?? const []).cast<String>(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'permissions': permissions,
    };
  }
}
