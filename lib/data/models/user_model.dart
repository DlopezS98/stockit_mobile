class UserModel {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final int roleId;
  final String roleName;
  final DateTime createdAt;

  final String _firstName;
  final String _lastName;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.roleId,
    required this.roleName,
    required this.createdAt,
  }): 
    _firstName = '',
    _lastName = '';

  UserModel._createRequest({
    required this.email,
    required this._firstName,
    required this._lastName,
    required this.roleId
  })  : fullName = '',
        id = 0,
        username = '',
        roleName = '',
        createdAt = DateTime.now();

  UserModel._updateRequest({
    required this._firstName,
    required this._lastName,
    required this.roleId
  })  : email = '',
        fullName = '',
        id = 0,
        username = '',
        roleName = '',
        createdAt = DateTime.now();

  static UserModel fromCreateJson({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required int roleId,
  }) {
    return UserModel._createRequest(
      email: email,
      firstName: firstName,
      lastName: lastName,
      roleId: roleId,
    );
  }

  static UserModel fromUpdateJson({
    required String firstName,
    required String lastName,
    required int roleId,
  }) {
    return UserModel._updateRequest(
      firstName: firstName,
      lastName: lastName,
      roleId: roleId,
    );
  }


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

  Map<String, dynamic> toCreateJson() {
    return {
      'email': email,
      'firstName': _firstName,
      'lastName': _lastName,
      'roleId': roleId,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'firstName': _firstName,
      'lastName': _lastName,
      'roleId': roleId,
    };
  }
}