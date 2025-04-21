import 'package:dio/dio.dart';

abstract class RegisterDataSources {
  Future register({required FormData formData});
}
