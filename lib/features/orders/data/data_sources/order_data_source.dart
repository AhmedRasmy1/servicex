import 'package:dio/dio.dart';
import '../../../../core/common/api_result.dart';
import '../../domain/entities/order_entity.dart';

abstract class OrderDataSource {
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  });
}

abstract class PendingOrderDataSource {
  Future<Result<List<PendingOrderModelEntity>>> getAllPendingOrder({
    required String token,
  });
}
