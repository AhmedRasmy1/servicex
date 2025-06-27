// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    ServicesModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };

TopServicesModel _$TopServicesModelFromJson(Map<String, dynamic> json) =>
    TopServicesModel(
      serviceName: json['serviceName'] as String?,
      orderCount: (json['orderCount'] as num?)?.toInt(),
    )..image = json['image'] as String?;

Map<String, dynamic> _$TopServicesModelToJson(TopServicesModel instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceName,
      'orderCount': instance.orderCount,
      'image': instance.image,
    };

TechniciansForServices _$TechniciansForServicesFromJson(
  Map<String, dynamic> json,
) => TechniciansForServices(
  technicalId: json['technicalId'] as String?,
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  imageUrl: json['imageUrl'] as String?,
  payByHour: (json['payByHour'] as num?)?.toInt(),
  serviceName: json['serviceName'] as String?,
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  totalReviews: (json['totalReviews'] as num?)?.toInt(),
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => Reviews.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TechniciansForServicesToJson(
  TechniciansForServices instance,
) => <String, dynamic>{
  'technicalId': instance.technicalId,
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
  'payByHour': instance.payByHour,
  'serviceName': instance.serviceName,
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
