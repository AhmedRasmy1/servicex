import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/domain/entities/add_review_entity.dart';
import 'package:servicex/features/orders/domain/repo/add_review_repo.dart';

@injectable
class AddReviewUsecase {
  AddReviewRepo addReviewRepo;

  AddReviewUsecase({required this.addReviewRepo});
  Future<Result<AddReviewEntity>> addReview({
    required String token,
    required String orderId,
    required int rating,
    required String comment,
  }) {
    return addReviewRepo.addReview(
      token: token,
      orderId: orderId,
      rating: rating,
      comment: comment,
    );
  }
}
