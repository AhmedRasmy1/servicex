import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/add_review_data_source.dart';
import '../../domain/entities/add_review_entity.dart';
import '../../domain/repo/add_review_repo.dart';

@Injectable(as: AddReviewRepo)
class AddReviewRepoImpl implements AddReviewRepo {
  AddReviewDataSource addReviewDataSourceImpl;
  AddReviewRepoImpl(this.addReviewDataSourceImpl);
  @override
  Future<Result<AddReviewEntity>> addReview({
    required String token,
    required String orderId,
    required int rating,
    required String comment,
  }) {
    return addReviewDataSourceImpl.addReview(
      token: token,
      orderId: orderId,
      rating: rating,
      comment: comment,
    );
  }
}
