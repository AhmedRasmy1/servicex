import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/data/data_sources/order_data_source.dart';
import 'package:servicex/features/orders/domain/entities/order_entity.dart';

@Injectable(as: OrderDataSource)
class OrderDataSourceImpl implements OrderDataSource {
  ApiService apiService;

  OrderDataSourceImpl({required this.apiService});
  @override
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  }) {
    return executeApi(() async {
      final response = await apiService.createOrder(
        technicianId,
        token,
        formData,
      );
      final data = response.toCreateOrderEntity();
      return data;
    });
  }
}
