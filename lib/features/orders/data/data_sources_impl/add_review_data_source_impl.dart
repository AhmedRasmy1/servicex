import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/data/data_sources/add_review_data_source.dart';
import 'package:servicex/features/orders/domain/entities/add_review_entity.dart';

@Injectable(as: AddReviewDataSource)
class AddReviewDataSourceImpl implements AddReviewDataSource {
  ApiService apiService;
  AddReviewDataSourceImpl(this.apiService);
  @override
  Future<Result<AddReviewEntity>> addReview({
    required String token,
    required String orderId,
    required int rating,
    required String comment,
  }) {
    return executeApi<AddReviewEntity>(() async {
      final response = await apiService.addReviewByUser(
        token,
        orderId,
        rating,
        comment,
      );
      return response.toAddReviewEntity();
    });
  }
}
