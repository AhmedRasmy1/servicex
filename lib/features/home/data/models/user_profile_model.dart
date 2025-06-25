import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_profile_entity.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class MyBalance {
  String? message;
  int? newBalance;

  MyBalance({this.message, this.newBalance});

  factory MyBalance.fromJson(Map<String, dynamic> json) =>
      _$MyBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$MyBalanceToJson(this);

  MyBalanceEntity toMyBalanceEntity() {
    return MyBalanceEntity(message: message, newBalance: newBalance);
  }
}

@JsonSerializable()
class UserProfile {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  int? balanace;
  String? profileImageUrl;

  UserProfile({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.balanace,
    this.profileImageUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfileEntity toUserProfileEntity() {
    return UserProfileEntity(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      balance: balanace,
      profileImageUrl: profileImageUrl,
    );
  }
}
