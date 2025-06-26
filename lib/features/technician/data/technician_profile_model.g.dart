// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technician_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TechnicianProfileModel _$TechnicianProfileModelFromJson(
  Map<String, dynamic> json,
) => TechnicianProfileModel(
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  address: json['address'] as String?,
  serviceName: json['serviceName'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$TechnicianProfileModelToJson(
  TechnicianProfileModel instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'address': instance.address,
  'serviceName': instance.serviceName,
  'profileImageUrl': instance.profileImageUrl,
};
