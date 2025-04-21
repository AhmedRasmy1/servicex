import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/api/api_extentions.dart';
import '../../../../core/api/api_manager/api_manager.dart';
import '../data_sources/register_data_sources.dart';

@Injectable(as: RegisterDataSources)
class RegisterDataSorucesImpl implements RegisterDataSources {
  ApiService apiService;
  RegisterDataSorucesImpl({required this.apiService});
  @override
  Future register({required FormData formData}) {
    return executeApi(() => apiService.register(formData));
  }
}
