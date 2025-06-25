class CreateOrderEntity {
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
  CreateOrderEntity({
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
}

class PendingOrderModelEntity {
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

  PendingOrderModelEntity({
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
}
