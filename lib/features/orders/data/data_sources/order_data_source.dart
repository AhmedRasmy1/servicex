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

abstract class CompleteOrderDataSource {
  Future<Result<List<CompletedOrderModelEntity>>> completeOrder({
    required String token,
  });
}

abstract class CompleteOrderByCustomerDataSource {
  Future completeOrderByCustomer({
    required String orderId,
    required String token,
  });
}

abstract class CompletedOrderForTechnicianDataSource {
  Future<Result<List<CompleteOrderEntityForTechnician>>> getCompletedOrders({
    required String token,
  });
}

abstract class PindingOrderForTechnicianDataSource {
  Future<Result<List<PendingOrderEntityForTechnician>>>
  getPendingOrdersForTechnician({required String token});
}

abstract class CompletedOrderByTechnicianDataSource {
  Future<Result<CompletedOrderEntityForTechnician>>
  getCompletedOrdersByTechnician({
    required String orderId,
    required int period,
    required String token,
  });
}
