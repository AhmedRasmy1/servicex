import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/api_result.dart';
import '../entities/order_entity.dart';
import '../repo/order_repo.dart';

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
