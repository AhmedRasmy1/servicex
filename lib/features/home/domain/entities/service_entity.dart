import 'package:servicex/features/home/data/models/services_model.dart';

class ServiceEntity {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

class TopServicesEntity {
  final String serviceName;
  final int orderCount;

  TopServicesEntity({required this.serviceName, required this.orderCount});
}

class TechniciansForServicesEntity {
  String? technicalId;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? imageUrl;
  int? payByHour;
  String? serviceName;
  double? averageRating;
  int? totalReviews;
  List<Reviews>? reviews;

  TechniciansForServicesEntity({
    required this.technicalId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.payByHour,
    required this.serviceName,
    required this.averageRating,
    required this.totalReviews,
    required this.reviews,
  });
}
