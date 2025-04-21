import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import 'package:servicex/core/api/api_extentions.dart';
import 'package:servicex/core/api/api_manager/api_manager.dart';
import 'package:servicex/features/auth/data/data_sources/register_data_sources.dart';

@Injectable(as: RegisterDataSources)
class RegisterDataSorucesImpl implements RegisterDataSources {
  ApiService apiService;
  RegisterDataSorucesImpl({required this.apiService});
  @override
  Future register({required FormData formData}) {
    return executeApi(() => apiService.register(formData));
  }
}
