import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:servicex/core/common/api_result.dart';
import 'package:servicex/features/orders/domain/entities/order_entity.dart';
import 'package:servicex/features/orders/domain/repo/order_repo.dart';

@injectable
class OrderUsecase {
  OrderRepo orderRepo;
  OrderUsecase({required this.orderRepo});
  Future<Result<CreateOrderEntity>> createOrder({
    required String technicianId,
    required String token,
    required FormData formData,
  }) {
    return orderRepo.createOrder(
      technicianId: technicianId,
      token: token,
      formData: formData,
    );
  }
}
