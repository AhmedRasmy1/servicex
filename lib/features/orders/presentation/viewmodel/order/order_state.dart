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
