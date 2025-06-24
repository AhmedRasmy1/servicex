import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/service_entity.dart';
part 'services_model.g.dart';

@JsonSerializable()
class ServicesModel {
  int? id;
  String? name;
  String? description;
  String? imageUrl;

  ServicesModel({this.id, this.name, this.description, this.imageUrl});

  factory ServicesModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);

  ServiceEntity toServicesEntity() {
    return ServiceEntity(
      id: id ?? 0,
      name: name ?? '',
      description: description ?? '',
      imageUrl: imageUrl ?? '',
    );
  }
}

@JsonSerializable()
class TopServicesModel {
  String? serviceName;
  int? orderCount;

  TopServicesModel({this.serviceName, this.orderCount});
  factory TopServicesModel.fromJson(Map<String, dynamic> json) =>
      _$TopServicesModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopServicesModelToJson(this);
  TopServicesEntity toTopServicesEntity() {
    return TopServicesEntity(
      serviceName: serviceName ?? '',
      orderCount: orderCount ?? 0,
    );
  }
}

@JsonSerializable()
class TechniciansForServices {
  String? technicalId;
  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? imageUrl;
  int? payByHour;
  String? name;

  TechniciansForServices({
    this.technicalId,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.imageUrl,
    this.payByHour,
    this.name,
  });
  factory TechniciansForServices.fromJson(Map<String, dynamic> json) =>
      _$TechniciansForServicesFromJson(json);
  Map<String, dynamic> toJson() => _$TechniciansForServicesToJson(this);
  TechniciansForServicesEntity toTechniciansForServicesEntity() {
    return TechniciansForServicesEntity(
      technicalId: technicalId ?? '',
      fullName: fullName ?? '',
      email: email ?? '',
      phone: phone ?? '',
      address: address ?? '',
      imageUrl: imageUrl ?? '',
      payByHour: payByHour ?? 0,
      name: name ?? '',
    );
  }
}
