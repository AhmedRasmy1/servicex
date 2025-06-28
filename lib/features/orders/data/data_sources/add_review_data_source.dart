import '../../../../core/common/api_result.dart';
import '../../domain/entities/add_review_entity.dart';

abstract class AddReviewDataSource {
  Future<Result<AddReviewEntity>> addReview({
    required String token,
    required String orderId,
    required int rating,
    required String comment,
  });
}
