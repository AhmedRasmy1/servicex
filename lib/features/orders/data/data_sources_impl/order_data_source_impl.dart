import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../../../../core/common/api_result.dart';
import '../data_sources/order_data_source.dart';
import '../../domain/entities/order_entity.dart';

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

@Injectable(as: PendingOrderDataSource)
class PendingOrderDataSourceImpl implements PendingOrderDataSource {
  ApiService apiService;

  PendingOrderDataSourceImpl({required this.apiService});
  @override
  Future<Result<List<PendingOrderModelEntity>>> getAllPendingOrder({
    required String token,
  }) {
    return executeApi<List<PendingOrderModelEntity>>(() async {
      final response = await apiService.getAllPendingOrder(token);
      final data =
          response.map((order) => order.toPendingOrderModelEntity()).toList();
      return data;
    });
  }
}
