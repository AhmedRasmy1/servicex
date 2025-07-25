import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../entities/order_entity.dart';
import '../repo/order_repo.dart';

@injectable
class OrderUsecase {
  OrderRepo orderRepo;
  OrderUsecase({required this.orderRepo});
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  }) {
    return orderRepo.createOrder(
      technicianId: technicianId,
      token: token,
      formData: formData,
    );
  }
}

@injectable
class PendingOrderUsecase {
  PendingOrderRepo pendingOrderRepo;
  PendingOrderUsecase({required this.pendingOrderRepo});
  Future<Result<List<PendingOrderModelEntity>>> getAllPendingOrder({
    required String token,
  }) {
    return pendingOrderRepo.getAllPendingOrder(token: token);
  }
}

@injectable
class CompleteOrderUsecase {
  CompleteOrderRepo completeOrderRepo;
  CompleteOrderUsecase({required this.completeOrderRepo});
  Future<Result<List<CompletedOrderModelEntity>>> completeOrder({
    required String token,
  }) {
    return completeOrderRepo.completeOrder(token: token);
  }
}

@injectable
class CompleteOrderByCustomerUsecase {
  CompleteOrderByCustomerRepo completeOrderByCustomerRepo;
  CompleteOrderByCustomerUsecase({required this.completeOrderByCustomerRepo});
  Future completeOrderByCustomer({
    required String orderId,
    required String token,
  }) {
    return completeOrderByCustomerRepo.completeOrderByCustomer(
      orderId: orderId,
      token: token,
    );
  }
}

@injectable
class CompletedOrderForTechnicianUsecase {
  CompletedOrderForTechnician completedOrderForTechnician;
  CompletedOrderForTechnicianUsecase({
    required this.completedOrderForTechnician,
  });
  Future<Result<List<CompleteOrderEntityForTechnician>>> getCompletedOrders({
    required String token,
  }) {
    return completedOrderForTechnician.getCompletedOrders(token: token);
  }
}

@injectable
class PendingOrderForTechnicianUsecase {
  PindingOrderRepoForTechnician pindingOrderRepoForTechnician;
  PendingOrderForTechnicianUsecase({
    required this.pindingOrderRepoForTechnician,
  });
  Future<Result<List<PendingOrderEntityForTechnician>>>
  getPendingOrdersForTechnician({required String token}) {
    return pindingOrderRepoForTechnician.getPendingOrdersForTechnician(
      token: token,
    );
  }
}

@injectable
class CompletedOrderByTechnicianUsecase {
  CompletedOrderByTechnicianRepo completedOrderByTechnician;
  CompletedOrderByTechnicianUsecase({required this.completedOrderByTechnician});
  Future<Result<CompletedOrderEntityForTechnician>>
  getCompletedOrdersByTechnician({
    required String orderId,
    required int period,
    required String token,
  }) {
    return completedOrderByTechnician.getCompletedOrdersByTechnician(
      orderId: orderId,
      period: period,
      token: token,
    );
  }
}
