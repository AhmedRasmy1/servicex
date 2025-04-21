import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/login_entity.dart';
part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  String? token;
  String? role;

  LoginModel({this.token, this.role});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);

  LoginEntity toLoginEntity() {
    return LoginEntity(token: token, role: role);
  }
}
