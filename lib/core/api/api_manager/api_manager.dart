import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:servicex/features/auth/data/models/login_model.dart';
import 'package:servicex/features/home/data/models/services_model.dart';
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
}
