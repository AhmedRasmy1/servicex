// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyBalance _$MyBalanceFromJson(Map<String, dynamic> json) => MyBalance(
  message: json['message'] as String?,
  newBalance: (json['newBalance'] as num?)?.toInt(),
);

Map<String, dynamic> _$MyBalanceToJson(MyBalance instance) => <String, dynamic>{
  'message': instance.message,
  'newBalance': instance.newBalance,
};

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  address: json['address'] as String?,
  balanace: (json['balanace'] as num?)?.toInt(),
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'balanace': instance.balanace,
      'profileImageUrl': instance.profileImageUrl,
    };
