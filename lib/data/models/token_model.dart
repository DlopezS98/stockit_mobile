class TokenModel {
  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });

  bool get isAccessTokenExpired => DateTime.now().isAfter(accessTokenExpiresAt);

  static TokenModel fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      accessTokenExpiresAt: DateTime.parse(json['expiresAt']),
      refreshTokenExpiresAt: DateTime.parse(json['refreshTokenExpiresAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresAt': accessTokenExpiresAt.toIso8601String(),
      'refreshTokenExpiresAt': refreshTokenExpiresAt.toIso8601String(),
    };
  }

  Map<String, String> toLogoutRequest() {
    return {'refreshToken': refreshToken};
  }
}
