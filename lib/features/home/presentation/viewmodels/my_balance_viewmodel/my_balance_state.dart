part of 'my_balance_cubit.dart';

@immutable
sealed class MyBalanceState {}

final class MyBalanceInitial extends MyBalanceState {}

final class MyBalanceLoading extends MyBalanceState {}

final class MyBalanceSuccess extends MyBalanceState {
  final MyBalanceEntity myBalanceEntity;
  MyBalanceSuccess({required this.myBalanceEntity});
}

final class MyBalanceFailed extends MyBalanceState {
  final Exception exception;
  MyBalanceFailed({required this.exception});
}
