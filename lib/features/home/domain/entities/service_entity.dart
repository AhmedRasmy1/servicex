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
  final String technicalId;
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String imageUrl;
  final int payByHour;
  final String name;

  TechniciansForServicesEntity({
    required this.technicalId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.payByHour,
    required this.name,
  });
}
