import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/order_data_source.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repo/order_repo.dart';

@Injectable(as: OrderRepo)
class OrderRepoImpl implements OrderRepo {
  OrderDataSource orderDataSource;
  OrderRepoImpl({required this.orderDataSource});
  @override
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  }) {
    return orderDataSource.createOrder(
      technicianId: technicianId,
      token: token,
      formData: formData,
    );
  }
}

@Injectable(as: PendingOrderRepo)
class PendingOrderRepoImpl implements PendingOrderRepo {
  PendingOrderDataSource pendingOrderDataSource;
  PendingOrderRepoImpl({required this.pendingOrderDataSource});

  @override
  Future<Result<List<PendingOrderModelEntity>>> getAllPendingOrder({
    required String token,
  }) {
    return pendingOrderDataSource.getAllPendingOrder(token: token);
  }
}

@Injectable(as: CompleteOrderRepo)
class CompleteOrderRepoImpl implements CompleteOrderRepo {
  CompleteOrderDataSource completeOrderDataSource;
  CompleteOrderRepoImpl({required this.completeOrderDataSource});
  @override
  Future<Result<List<CompletedOrderModelEntity>>> completeOrder({
    required String token,
  }) {
    return completeOrderDataSource.completeOrder(token: token);
  }
}

@Injectable(as: CompleteOrderByCustomerRepo)
class CompleteOrderByCustomerRepoImpl implements CompleteOrderByCustomerRepo {
  CompleteOrderByCustomerDataSource completeOrderByCustomerDataSource;
  CompleteOrderByCustomerRepoImpl({
    required this.completeOrderByCustomerDataSource,
  });

  @override
  Future completeOrderByCustomer({
    required String orderId,
    required String token,
  }) {
    return completeOrderByCustomerDataSource.completeOrderByCustomer(
      orderId: orderId,
      token: token,
    );
  }
}
