import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/core/utils/cashed_data_shared_preferences.dart';
import 'package:servicex/features/orders/domain/entities/add_review_entity.dart';
import 'package:servicex/features/orders/domain/usecase/add_review_usecase.dart';

part 'add_review_state.dart';

@injectable
class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewUsecase addReviewUsecase;
  AddReviewCubit(this.addReviewUsecase) : super(AddReviewInitial());
  Future<void> addReview({
    required String orderId,
    required int rating,
    required String comment,
  }) async {
    emit(AddReviewLoading());
    final token =
        'Bearer ${CacheService.getData(key: CacheConstants.userToken) ?? ''}';
    final result = await addReviewUsecase.addReview(
      token: token,
      orderId: orderId,
      rating: rating,
      comment: comment,
    );
    switch (result) {
      case Success<AddReviewEntity>():
        emit(AddReviewSuccess(addReviewEntity: result.data));
        break;
      case Fail<AddReviewEntity>():
        emit(AddReviewFailed(errorMessage: 'Error: ${result.exception}'));
        break;
    }
  }
}
