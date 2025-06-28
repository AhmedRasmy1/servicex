import '../../../../core/common/api_result.dart';
import '../entities/add_review_entity.dart';

abstract class AddReviewRepo {
  Future<Result<AddReviewEntity>> addReview({
    required String token,
    required String orderId,
    required int rating,
    required String comment,
  });
}
