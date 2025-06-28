import '../data/technician_profile_model.dart';

class TechnicianProfileEntity {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? profileImageUrl;
  String? serviceName;
  int? payByHour;
  double? averageRating;
  int? totalReviews;
  List<Reviews>? reviews;

  TechnicianProfileEntity({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.profileImageUrl,
    required this.serviceName,
    required this.payByHour,
    required this.averageRating,
    required this.totalReviews,
    required this.reviews,
  });
}
