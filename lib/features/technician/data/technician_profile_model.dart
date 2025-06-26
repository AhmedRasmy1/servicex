import 'package:json_annotation/json_annotation.dart';
import 'package:servicex/features/technician/domain/technician_profile_entity.dart';
part 'technician_profile_model.g.dart';

@JsonSerializable()
class TechnicianProfileModel {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? serviceName;
  String? profileImageUrl;

  TechnicianProfileModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.serviceName,
    this.profileImageUrl,
  });
  factory TechnicianProfileModel.fromJson(Map<String, dynamic> json) =>
      _$TechnicianProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$TechnicianProfileModelToJson(this);

  TechnicianProfileEntity toTechnicianProfileEntity() {
    return TechnicianProfileEntity(
      name: fullName,
      email: email,
      phone: phoneNumber,
      address: address,
      serviceName: serviceName,
      image: profileImageUrl,
    );
  }
}
