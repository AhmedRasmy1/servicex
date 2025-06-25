part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderSuccess extends OrderState {
  final CreateOrderEntity order;

  OrderSuccess({required this.order});
}

final class OrderFailed extends OrderState {
  final String message;

  OrderFailed({required this.message});
}

final class PendingOrderLoading extends OrderState {}

final class PendingOrderSuccess extends OrderState {
  final List<PendingOrderModelEntity> pendingOrders;

  PendingOrderSuccess({required this.pendingOrders});
}

final class PendingOrderFailed extends OrderState {
  final String message;

  PendingOrderFailed({required this.message});
}

final class CompleteOrderLoading extends OrderState {}

final class CompleteOrderSuccess extends OrderState {
  final List<CompletedOrderModelEntity> completedOrders;

  CompleteOrderSuccess({required this.completedOrders});
}

final class CompleteOrderFailed extends OrderState {
  final String message;

  CompleteOrderFailed({required this.message});
}

final class CompleteOrderForTechnicianLoading extends OrderState {}

final class CompleteOrderForTechnicianSuccess extends OrderState {
  final List<CompleteOrderEntityForTechnician> completedOrders;

  CompleteOrderForTechnicianSuccess({required this.completedOrders});
}

final class CompleteOrderForTechnicianFailed extends OrderState {
  final String message;

  CompleteOrderForTechnicianFailed({required this.message});
}

final class CompleteOrderByCustomerLoading extends OrderState {
  final int loadingOrderId;

  CompleteOrderByCustomerLoading({required this.loadingOrderId});
}

final class CompleteOrderByCustomerSuccess extends OrderState {
  final String message;
  final int completedOrderId;

  CompleteOrderByCustomerSuccess({
    required this.message,
    required this.completedOrderId,
  });
}

final class CompleteOrderByCustomerFailed extends OrderState {
  final String message;
  final int failedOrderId;

  CompleteOrderByCustomerFailed({
    required this.message,
    required this.failedOrderId,
  });
}
