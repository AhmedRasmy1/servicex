import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:servicex/features/technician/data/technician_profile_model.dart';
import '../../../features/home/data/models/user_profile_model.dart';
import '../../../features/orders/data/models/order_model.dart';
import '../../../features/auth/data/models/login_model.dart';
import '../../../features/home/data/models/services_model.dart';
import '../api_constants.dart';
part 'api_manager.g.dart';

@injectable
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @FactoryMethod()
  factory ApiService(Dio dio) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginModel> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST(ApiConstants.sentOtp)
  Future sentOtp(@Field('email') String email);
  @POST(ApiConstants.verifyOtp)
  Future verifyOtp(@Field('otpCode') String otpCode);
  @POST(ApiConstants.resetPassword)
  Future resetPassword(
    @Field('email') String email,
    @Field('newPassword') String password,
  );

  @GET(ApiConstants.getAllServices)
  Future<List<ServicesModel>> getAllServices();
  @POST(ApiConstants.register)
  @MultiPart()
  Future register(@Body() FormData formData);

  @POST('${ApiConstants.charegeBalance}/{code}')
  Future<MyBalance> chargeBalance(
    @Path('code') String code,
    @Header('Authorization') String token,
  );
  @GET(ApiConstants.getUserProfile)
  Future<UserProfile> getUserProfile(@Header('Authorization') String token);
  @GET(ApiConstants.topServices)
  Future<List<TopServicesModel>> getTopServices();
  @GET(ApiConstants.getTechniciansForServices)
  Future<List<TechniciansForServices>> getTechniciansForServices(
    @Path('serviceId') String serviceId,
  );
  @POST(ApiConstants.createOrder)
  @MultiPart()
  Future<CreateOrderModel> createOrder(
    @Path('technicianId') String technicianId,
    @Header('Authorization') String token,
    @Body() FormData formData,
  );

  @GET(ApiConstants.getAllPendingOrder)
  Future<List<PendingOrderModel>> getAllPendingOrder(
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getAllCompletedOrder)
  Future<List<CompleteOrderModel>> getAllCompletedOrder(
    @Header('Authorization') String token,
  );

  @PUT(ApiConstants.completeOrderByCustomer)
  Future completeOrderByCustomer(
    @Path('orderId') String orderId,
    @Header('Authorization') String token,
  );

  @GET(ApiConstants.getAllCompletedOrderForTechnician)
  Future<List<CompleteOrderModelForTechnician>>
  getAllCompletedOrderForTechnician(@Header('Authorization') String token);

  @GET(ApiConstants.getAllPendingOrderForTechnician)
  Future<List<PendingOrderModelForTechnician>> getAllPendingOrderForTechnician(
    @Header('Authorization') String token,
  );

  @PUT(ApiConstants.completeOrderByTechnician)
  Future<CompletedOrderModelByTechnician> completeOrderByTechnician(
    @Path('orderId') String orderId,
    @Field('Period') int period,
    @Header('Authorization') String token,
  );
  @GET(ApiConstants.getTechnicianProfile)
  Future<TechnicianProfileModel> getTechnicianProfile(
    @Header('Authorization') String token,
  );
}
