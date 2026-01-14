import '../../domain/entity/auth_entity.dart';

class RegisterModel{
  final String id;
  final String userName;
  final String role;
  final String accessToken;

  const RegisterModel({
    required this.id,
    required this.userName,
    required this.role,
    required this.accessToken,
  });

  factory RegisterModel.fromJson(Map<String,dynamic> json){
    return RegisterModel(
        id: json['userPayload']['id'],
        userName: json['userPayload']['userName'],
        role: json['userPayload']['role'],
        accessToken: json['accessToken']
    );

  }

  // extension function " AuthModel.toEntity "
  LoginEntity toEntity(){
    return LoginEntity(id: id, userName: userName, role: role, accessToken: accessToken);

  }

}