import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/entity/login_entity.dart';

class LoginModel {
  final String id;
  final String userName;
  final String role;
  final String accessToken;

  const LoginModel({
    required this.id,
    required this.userName,
    required this.role,
    required this.accessToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['userPayload']['id'],
      userName: json['userPayload']['userName'],
      role: json['userPayload']['role'],
      accessToken: json['accessToken'],
    );
  }

  LoginEntity toEntity(){
    return LoginEntity(id: id, userName: userName, role: role, accessToken: accessToken);
  }
}
