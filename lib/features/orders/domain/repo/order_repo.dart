import 'package:dio/dio.dart';
import '../../../../core/common/api_result.dart';
import '../entities/order_entity.dart';

abstract class OrderRepo {
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  });
}
