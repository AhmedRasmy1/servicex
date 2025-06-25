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
