import 'package:dio/src/form_data.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/register_data_sources.dart';
import '../../domain/repo/register_repo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImpl implements RegisterRepo {
  RegisterDataSources registerDataSources;
  RegisterRepoImpl({required this.registerDataSources});
  @override
  Future register({required FormData formData}) {
    return registerDataSources.register(formData: formData);
  }
}
