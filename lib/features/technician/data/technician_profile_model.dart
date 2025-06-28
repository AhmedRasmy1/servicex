import 'package:json_annotation/json_annotation.dart';
import '../domain/technician_profile_entity.dart';
part 'technician_profile_model.g.dart';

@JsonSerializable()
class TechnicianProfileModel {
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

  TechnicianProfileModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.profileImageUrl,
    this.serviceName,
    this.payByHour,
    this.averageRating,
    this.totalReviews,
    this.reviews,
  });

  factory TechnicianProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicianProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$TechnicianProfileModelToJson(this);
  TechnicianProfileEntity toTechnicianProfileEntity() {
    return TechnicianProfileEntity(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      address: address,
      profileImageUrl: profileImageUrl,
      serviceName: serviceName,
      payByHour: payByHour,
      averageRating: averageRating,
      totalReviews: totalReviews,
      reviews: reviews,
    );
  }
}

@JsonSerializable()
class Reviews {
  int? ratingValue;
  String? comments;
  String? customerName;
  int? orderId;

  Reviews({this.ratingValue, this.comments, this.customerName, this.orderId});
  factory Reviews.fromJson(Map<String, dynamic> json) =>
      _$ReviewsFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsToJson(this);
}
