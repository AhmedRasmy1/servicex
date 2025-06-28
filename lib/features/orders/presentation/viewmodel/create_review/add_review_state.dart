part of 'add_review_cubit.dart';

@immutable
sealed class AddReviewState {}

final class AddReviewInitial extends AddReviewState {}

final class AddReviewLoading extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {
  final AddReviewEntity addReviewEntity;

  AddReviewSuccess({required this.addReviewEntity});
}

final class AddReviewFailed extends AddReviewState {
  final Exception errorMessage;

  AddReviewFailed({required this.errorMessage});
}
