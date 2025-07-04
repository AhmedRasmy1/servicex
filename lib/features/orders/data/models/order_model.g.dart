// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderModel _$CreateOrderModelFromJson(Map<String, dynamic> json) =>
    CreateOrderModel(
      id: (json['id'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      orderStatus: json['orderStatus'] as String?,
      problemDescription: json['problemDescription'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      technicianName: json['technicianName'] as String?,
      serviceName: json['serviceName'] as String?,
      isCompletedByCustomer: json['isCompletedByCustomer'] as bool?,
      isCompletedByTechnician: json['isCompletedByTechnician'] as bool?,
      period: (json['period'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CreateOrderModelToJson(CreateOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'orderStatus': instance.orderStatus,
      'problemDescription': instance.problemDescription,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
      'technicianName': instance.technicianName,
      'serviceName': instance.serviceName,
      'isCompletedByCustomer': instance.isCompletedByCustomer,
      'isCompletedByTechnician': instance.isCompletedByTechnician,
      'period': instance.period,
      'price': instance.price,
    };

PendingOrderModel _$PendingOrderModelFromJson(Map<String, dynamic> json) =>
    PendingOrderModel(
      id: (json['id'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      orderStatus: json['orderStatus'] as String?,
      problemDescription: json['problemDescription'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      technicianName: json['technicianName'] as String?,
      serviceName: json['serviceName'] as String?,
      isCompletedByCustomer: json['isCompletedByCustomer'] as bool?,
      isCompletedByTechnician: json['isCompletedByTechnician'] as bool?,
      period: (json['period'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PendingOrderModelToJson(PendingOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'orderStatus': instance.orderStatus,
      'problemDescription': instance.problemDescription,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
      'technicianName': instance.technicianName,
      'serviceName': instance.serviceName,
      'isCompletedByCustomer': instance.isCompletedByCustomer,
      'isCompletedByTechnician': instance.isCompletedByTechnician,
      'period': instance.period,
      'price': instance.price,
    };

CompleteOrderModel _$CompleteOrderModelFromJson(Map<String, dynamic> json) =>
    CompleteOrderModel(
      id: (json['id'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      orderStatus: json['orderStatus'] as String?,
      problemDescription: json['problemDescription'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      technicianName: json['technicianName'] as String?,
      serviceName: json['serviceName'] as String?,
      isCompletedByCustomer: json['isCompletedByCustomer'] as bool?,
      isCompletedByTechnician: json['isCompletedByTechnician'] as bool?,
      period: (json['period'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CompleteOrderModelToJson(CompleteOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'orderStatus': instance.orderStatus,
      'problemDescription': instance.problemDescription,
      'date': instance.date,
      'time': instance.time,
      'address': instance.address,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
      'technicianName': instance.technicianName,
      'serviceName': instance.serviceName,
      'isCompletedByCustomer': instance.isCompletedByCustomer,
      'isCompletedByTechnician': instance.isCompletedByTechnician,
      'period': instance.period,
      'price': instance.price,
    };

CompleteOrderModelForTechnician _$CompleteOrderModelForTechnicianFromJson(
  Map<String, dynamic> json,
) => CompleteOrderModelForTechnician(
  id: (json['id'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  orderStatus: json['orderStatus'] as String?,
  problemDescription: json['problemDescription'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  imageUrl: json['imageUrl'] as String?,
  technicianName: json['technicianName'] as String?,
  serviceName: json['serviceName'] as String?,
  isCompletedByCustomer: json['isCompletedByCustomer'] as bool?,
  isCompletedByTechnician: json['isCompletedByTechnician'] as bool?,
  period: (json['period'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toInt(),
);

Map<String, dynamic> _$CompleteOrderModelForTechnicianToJson(
  CompleteOrderModelForTechnician instance,
) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'orderStatus': instance.orderStatus,
  'problemDescription': instance.problemDescription,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'phone': instance.phone,
  'imageUrl': instance.imageUrl,
  'technicianName': instance.technicianName,
  'serviceName': instance.serviceName,
  'isCompletedByCustomer': instance.isCompletedByCustomer,
  'isCompletedByTechnician': instance.isCompletedByTechnician,
  'period': instance.period,
  'price': instance.price,
};

PendingOrderModelForTechnician _$PendingOrderModelForTechnicianFromJson(
  Map<String, dynamic> json,
) => PendingOrderModelForTechnician(
  id: (json['id'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  orderStatus: json['orderStatus'] as String?,
  problemDescription: json['problemDescription'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  imageUrl: json['imageUrl'] as String?,
  technicianName: json['technicianName'] as String?,
  serviceName: json['serviceName'] as String?,
  isCompletedByCustomer: json['isCompletedByCustomer'] as bool?,
  isCompletedByTechnician: json['isCompletedByTechnician'] as bool?,
  period: (json['period'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toInt(),
);

Map<String, dynamic> _$PendingOrderModelForTechnicianToJson(
  PendingOrderModelForTechnician instance,
) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'orderStatus': instance.orderStatus,
  'problemDescription': instance.problemDescription,
  'date': instance.date,
  'time': instance.time,
  'address': instance.address,
  'phone': instance.phone,
  'imageUrl': instance.imageUrl,
  'technicianName': instance.technicianName,
  'serviceName': instance.serviceName,
  'isCompletedByCustomer': instance.isCompletedByCustomer,
  'isCompletedByTechnician': instance.isCompletedByTechnician,
  'period': instance.period,
  'price': instance.price,
};

CompletedOrderModelByTechnician _$CompletedOrderModelByTechnicianFromJson(
  Map<String, dynamic> json,
) => CompletedOrderModelByTechnician(
  message: json['message'] as String?,
  totalPrice: (json['totalPrice'] as num?)?.toInt(),
);

Map<String, dynamic> _$CompletedOrderModelByTechnicianToJson(
  CompletedOrderModelByTechnician instance,
) => <String, dynamic>{
  'message': instance.message,
  'totalPrice': instance.totalPrice,
};
