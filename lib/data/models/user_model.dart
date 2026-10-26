class UserModel {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final int roleId;
  final String roleName;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.roleId,
    required this.roleName,
    required this.createdAt,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      roleId: json['roleId'] as int,
      roleName: json['roleName'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullName': fullName,
      'roleId': roleId,
      'roleName': roleName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}