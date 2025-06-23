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
