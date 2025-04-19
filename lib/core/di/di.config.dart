// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/data_sources/login_data_source.dart' as _i466;
import '../../features/auth/data/data_sources_impl/login_data_source_impl.dart'
    as _i785;
import '../../features/auth/data/repo_impl/login_repo_impl.dart' as _i204;
import '../../features/auth/domain/repo/login_repo.dart' as _i543;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart'
    as _i716;
import '../api/api_manager/api_manager.dart' as _i680;
import '../api/dio_module.dart' as _i784;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.providerDio());
    gh.factory<_i680.ApiService>(() => _i680.ApiService(gh<_i361.Dio>()));
    gh.factory<_i466.LoginDataSource>(
      () => _i785.LoginDataSourceImpl(gh<_i680.ApiService>()),
    );
    gh.factory<_i543.LoginRepo>(
      () => _i204.LoginRepoImpl(gh<_i466.LoginDataSource>()),
    );
    gh.factory<_i188.LoginUsecase>(
      () => _i188.LoginUsecase(gh<_i543.LoginRepo>()),
    );
    gh.factory<_i716.LoginCubit>(
      () => _i716.LoginCubit(gh<_i188.LoginUsecase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
