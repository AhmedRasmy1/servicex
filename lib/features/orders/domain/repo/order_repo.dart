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

abstract class PendingOrderRepo {
  Future<Result<List<PendingOrderModelEntity>>> getAllPendingOrder({
    required String token,
  });
}

abstract class CompleteOrderRepo {
  Future<Result<List<CompletedOrderModelEntity>>> completeOrder({
    required String token,
  });
}

abstract class CompleteOrderByCustomerRepo {
  Future completeOrderByCustomer({
    required String orderId,
    required String token,
  });
}

abstract class CompletedOrderForTechnician {
  Future<Result<List<CompleteOrderEntityForTechnician>>> getCompletedOrders({
    required String token,
  });
}
