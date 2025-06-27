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
  profileImageUrl: json['profileImageUrl'] as String?,
  serviceName: json['serviceName'] as String?,
  payByHour: (json['payByHour'] as num?)?.toInt(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  totalReviews: (json['totalReviews'] as num?)?.toInt(),
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TechnicianProfileModelToJson(
  TechnicianProfileModel instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'address': instance.address,
  'profileImageUrl': instance.profileImageUrl,
  'serviceName': instance.serviceName,
  'payByHour': instance.payByHour,
  'averageRating': instance.averageRating,
  'totalReviews': instance.totalReviews,
  'reviews': instance.reviews,
};

Reviews _$ReviewsFromJson(Map<String, dynamic> json) => Reviews(
  ratingValue: (json['ratingValue'] as num?)?.toInt(),
  comments: json['comments'] as String?,
  customerName: json['customerName'] as String?,
  orderId: (json['orderId'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReviewsToJson(Reviews instance) => <String, dynamic>{
  'ratingValue': instance.ratingValue,
  'comments': instance.comments,
  'customerName': instance.customerName,
  'orderId': instance.orderId,
};
