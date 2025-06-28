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
class CompleteOrderCubit extends Cubit<OrderState> {
  final CompleteOrderUsecase _completeOrderUsecase;
  CompleteOrderCubit(this._completeOrderUsecase) : super(OrderInitial());
  Future<void> getAllCompletedOrder() async {
    emit(CompleteOrderLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await _completeOrderUsecase.completeOrder(token: token);
    switch (result) {
      case Success<List<CompletedOrderModelEntity>>():
        emit(CompleteOrderSuccess(completedOrders: result.data));
        break;
      case Fail<List<CompletedOrderModelEntity>>():
        emit(CompleteOrderFailed(message: 'Error: ${result.exception}'));
        break;
    }
  }
}

@injectable
class CompleteOrderForTechnicianCubit extends Cubit<OrderState> {
  final CompletedOrderForTechnicianUsecase _completeOrderForTechnicianUsecase;

  CompleteOrderForTechnicianCubit(this._completeOrderForTechnicianUsecase)
    : super(OrderInitial());

  Future<void> getCompletedOrders() async {
    emit(CompleteOrderForTechnicianLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await _completeOrderForTechnicianUsecase.getCompletedOrders(
      token: token,
    );
    switch (result) {
      case Success<List<CompleteOrderEntityForTechnician>>():
        emit(CompleteOrderForTechnicianSuccess(completedOrders: result.data));
        break;
      case Fail<List<CompleteOrderEntityForTechnician>>():
        emit(
          CompleteOrderForTechnicianFailed(
            message: 'Error: ${result.exception}',
          ),
        );
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

@injectable
class PendingOrderForTechnicianCubit extends Cubit<OrderState> {
  final PendingOrderForTechnicianUsecase _pendingOrderForTechnicianUsecase;
  PendingOrderForTechnicianCubit(this._pendingOrderForTechnicianUsecase)
    : super(OrderInitial());
  Future<void> getPendingOrdersForTechnician() async {
    emit(PendingOrderForTechnicianLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await _pendingOrderForTechnicianUsecase
        .getPendingOrdersForTechnician(token: token);
    switch (result) {
      case Success<List<PendingOrderEntityForTechnician>>():
        emit(PendingOrderForTechnicianSuccess(pendingOrders: result.data));
        break;
      case Fail<List<PendingOrderEntityForTechnician>>():
        emit(
          PendingOrderForTechnicianFailed(
            message: 'Error: ${result.exception}',
          ),
        );
        break;
    }
  }
}

@injectable
class CompleteOrderByTechnicianCubit extends Cubit<OrderState> {
  final CompletedOrderByTechnicianUsecase _completeOrderByTechnicianUsecase;

  CompleteOrderByTechnicianCubit(this._completeOrderByTechnicianUsecase)
    : super(OrderInitial());

  Future<void> completeOrderByTechnician({
    required String orderId,
    required int period,
  }) async {
    final int id = int.tryParse(orderId) ?? -1;

    emit(CompleteOrderByTechnicianLoading(loadingOrderId: id.toString()));

    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';

    final result = await _completeOrderByTechnicianUsecase
        .getCompletedOrdersByTechnician(
          orderId: orderId,
          period: period,
          token: token,
        );

    switch (result) {
      case Success<CompletedOrderEntityForTechnician>():
        emit(
          CompleteOrderByTechnicianSuccess(
            message: 'تم اكتمال الطلب بنجاح',
            completedOrderId: id.toString(),
          ),
        );
        break;

      case Fail<CompletedOrderEntityForTechnician>():
        emit(
          CompleteOrderByTechnicianFailed(
            message: result.exception,
            failedOrderId: id.toString(),
          ),
        );
        break;
    }
  }
}
