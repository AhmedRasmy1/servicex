import 'package:dio/dio.dart';

abstract class RegisterRepo {
  Future register({required FormData formData});
}
