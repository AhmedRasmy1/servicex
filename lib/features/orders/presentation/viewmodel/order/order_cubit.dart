import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/common/api_result.dart';
import '../../../../../core/utils/cashed_data_shared_preferences.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/usecase/order_usecase.dart';

part 'order_state.dart';

@injectable
class OrderCubit extends Cubit<OrderState> {
  final OrderUsecase _orderUsecase;
  OrderCubit(this._orderUsecase) : super(OrderInitial());
  Future<void> createOrder({
    required String technicianId,
    required FormData formData,
  }) async {
    emit(OrderLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await _orderUsecase.createOrder(
      technicianId: technicianId,
      token: token,
      formData: formData,
    );
    switch (result) {
      case Success<CreateOrderEntity>():
        emit(OrderSuccess(order: result.data));
        break;
      case Fail<CreateOrderEntity>():
        emit(OrderFailed(message: 'Error: ${result.exception}'));
        break;
    }
  }
}

@injectable
class PendingOrderCubit extends Cubit<OrderState> {
  final PendingOrderUsecase _pendingOrderUsecase;
  PendingOrderCubit(this._pendingOrderUsecase) : super(OrderInitial());
  Future<void> getAllPendingOrder() async {
    emit(PendingOrderLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await _pendingOrderUsecase.getAllPendingOrder(token: token);
    switch (result) {
      case Success<List<PendingOrderModelEntity>>():
        emit(PendingOrderSuccess(pendingOrders: result.data));
        break;
      case Fail<List<PendingOrderModelEntity>>():
        emit(PendingOrderFailed(message: 'Error: ${result.exception}'));
        break;
    }
  }
}

@injectable
class CompleteOrderByCustomerCubit extends Cubit<OrderState> {
  final CompleteOrderByCustomerUsecase _completeOrderByCustomerUsecase;

  CompleteOrderByCustomerCubit(this._completeOrderByCustomerUsecase)
    : super(OrderInitial());

  Future<void> completeOrderByCustomer({required String orderId}) async {
    final int id = int.tryParse(orderId) ?? -1;

    emit(CompleteOrderByCustomerLoading(loadingOrderId: id));

    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';

    final result = await _completeOrderByCustomerUsecase
        .completeOrderByCustomer(orderId: orderId, token: token);

    switch (result) {
      case Success<void>():
        emit(
          CompleteOrderByCustomerSuccess(
            message: 'تم اكتمال الطلب بنجاح',
            completedOrderId: id,
          ),
        );
        break;
      case Fail<void>():
        emit(
          CompleteOrderByCustomerFailed(
            message: 'حدث خطأ أثناء إتمام الطلب: ${result.exception}',
            failedOrderId: id,
          ),
        );
        break;
    }
  }
}
