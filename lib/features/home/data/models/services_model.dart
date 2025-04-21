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
