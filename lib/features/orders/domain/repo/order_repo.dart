import 'package:dio/dio.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepo {
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  });
}
