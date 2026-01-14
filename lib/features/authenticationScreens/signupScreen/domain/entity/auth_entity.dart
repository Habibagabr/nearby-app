class AuthEntity {
  final String id;
  final String userName;
  final String role;
  final String accessToken;

  const AuthEntity({
    required this.id,
    required this.userName,
    required this.role,
    required this.accessToken,
  });
}
