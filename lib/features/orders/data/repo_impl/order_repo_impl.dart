import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/data/data_sources/order_data_source.dart';
import 'package:servicex/features/orders/domain/entities/order_entity.dart';
import 'package:servicex/features/orders/domain/repo/order_repo.dart';

@Injectable(as: OrderRepo)
class OrderRepoImpl implements OrderRepo {
  OrderDataSource orderDataSource;
  OrderRepoImpl({required this.orderDataSource});
  @override
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  }) {
    return orderDataSource.createOrder(
      technicianId: technicianId,
      token: token,
      formData: formData,
    );
  }
}
