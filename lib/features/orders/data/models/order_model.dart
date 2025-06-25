import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_entity.dart';

part 'order_model.g.dart';

@JsonSerializable()
class CreateOrderModel {
  int? id;
  String? userName;
  String? orderStatus;
  String? problemDescription;
  String? date;
  String? time;
  String? address;
  String? phone;
  String? imageUrl;
  String? technicianName;
  String? serviceName;
  bool? isCompletedByCustomer;
  bool? isCompletedByTechnician;
  int? period;
  int? price;

  CreateOrderModel({
    this.id,
    this.userName,
    this.orderStatus,
    this.problemDescription,
    this.date,
    this.time,
    this.address,
    this.phone,
    this.imageUrl,
    this.technicianName,
    this.serviceName,
    this.isCompletedByCustomer,
    this.isCompletedByTechnician,
    this.period,
    this.price,
  });
  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderModelToJson(this);
  CreateOrderEntity toCreateOrderEntity() {
    return CreateOrderEntity(
      id: id,
      userName: userName,
      orderStatus: orderStatus,
      problemDescription: problemDescription,
      date: date,
      time: time,
      address: address,
      phone: phone,
      imageUrl: imageUrl,
      technicianName: technicianName,
      serviceName: serviceName,
      isCompletedByCustomer: isCompletedByCustomer,
      isCompletedByTechnician: isCompletedByTechnician,
      period: period,
      price: price,
    );
  }
}

@JsonSerializable()
class PendingOrderModel {
  int? id;
  String? userName;
  String? orderStatus;
  String? problemDescription;
  String? date;
  String? time;
  String? address;
  String? phone;
  String? imageUrl;
  String? technicianName;
  String? serviceName;
  bool? isCompletedByCustomer;
  bool? isCompletedByTechnician;
  int? period;
  int? price;

  PendingOrderModel({
    this.id,
    this.userName,
    this.orderStatus,
    this.problemDescription,
    this.date,
    this.time,
    this.address,
    this.phone,
    this.imageUrl,
    this.technicianName,
    this.serviceName,
    this.isCompletedByCustomer,
    this.isCompletedByTechnician,
    this.period,
    this.price,
  });
  factory PendingOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PendingOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$PendingOrderModelToJson(this);
  PendingOrderModelEntity toPendingOrderModelEntity() {
    return PendingOrderModelEntity(
      id: id,
      userName: userName,
      orderStatus: orderStatus,
      problemDescription: problemDescription,
      date: date,
      time: time,
      address: address,
      phone: phone,
      imageUrl: imageUrl,
      technicianName: technicianName,
      serviceName: serviceName,
      isCompletedByCustomer: isCompletedByCustomer,
      isCompletedByTechnician: isCompletedByTechnician,
      period: period,
      price: price,
    );
  }
}

@JsonSerializable()
class CompleteOrderModel {
  int? id;
  String? userName;
  String? orderStatus;
  String? problemDescription;
  String? date;
  String? time;
  String? address;
  String? phone;
  String? imageUrl;
  String? technicianName;
  String? serviceName;
  bool? isCompletedByCustomer;
  bool? isCompletedByTechnician;
  int? period;
  int? price;

  CompleteOrderModel({
    this.id,
    this.userName,
    this.orderStatus,
    this.problemDescription,
    this.date,
    this.time,
    this.address,
    this.phone,
    this.imageUrl,
    this.technicianName,
    this.serviceName,
    this.isCompletedByCustomer,
    this.isCompletedByTechnician,
    this.period,
    this.price,
  });
  factory CompleteOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CompleteOrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteOrderModelToJson(this);
  CompletedOrderModelEntity toCompletedOrderModelEntity() {
    return CompletedOrderModelEntity(
      id: id,
      userName: userName,
      orderStatus: orderStatus,
      problemDescription: problemDescription,
      date: date,
      time: time,
      address: address,
      phone: phone,
      imageUrl: imageUrl,
      technicianName: technicianName,
      serviceName: serviceName,
      isCompletedByCustomer: isCompletedByCustomer,
      isCompletedByTechnician: isCompletedByTechnician,
      period: period,
      price: price,
    );
  }
}
