import '../../domain/entity/auth_entity.dart';

class AuthModel{
  final String id;
  final String userName;
  final String role;
  final String accessToken;

  const AuthModel({
    required this.id,
    required this.userName,
    required this.role,
    required this.accessToken,
  });

  factory AuthModel.fromJson(Map<String,dynamic> json){
    return AuthModel(
        id: json['userPayload']['id'],
        userName: json['userPayload']['userName'],
        role: json['userPayload']['role'],
        accessToken: json['accessToken']
    );

  }

  // extension function " AuthModel.toEntity "
  AuthEntity toEntity(){
    return AuthEntity(id: id, userName: userName, role: role, accessToken: accessToken);

  }

}