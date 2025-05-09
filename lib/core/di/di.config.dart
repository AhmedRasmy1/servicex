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
import '../../features/auth/data/data_sources/register_data_sources.dart'
    as _i484;
import '../../features/auth/data/data_sources/reset_password_data_sources.dart'
    as _i956;
import '../../features/auth/data/data_sources/sent_otp_data_sources_impl.dart'
    as _i400;
import '../../features/auth/data/data_sources/verify_otp_data_source.dart'
    as _i398;
import '../../features/auth/data/data_sources_impl/login_data_source_impl.dart'
    as _i785;
import '../../features/auth/data/data_sources_impl/register_data_soruces_impl.dart'
    as _i525;
import '../../features/auth/data/data_sources_impl/reset_password_data_sources_impl.dart'
    as _i753;
import '../../features/auth/data/data_sources_impl/sent_otp_data_sources.dart'
    as _i575;
import '../../features/auth/data/data_sources_impl/verify_otp_data_sources_impl.dart'
    as _i1070;
import '../../features/auth/data/repo_impl/login_repo_impl.dart' as _i204;
import '../../features/auth/data/repo_impl/register_repo_impl.dart' as _i1058;
import '../../features/auth/data/repo_impl/reset_password_repo_impl.dart'
    as _i653;
import '../../features/auth/data/repo_impl/sent_otp_repo_impl.dart' as _i1020;
import '../../features/auth/data/repo_impl/verify_otp_repo_impl.dart' as _i214;
import '../../features/auth/domain/repo/login_repo.dart' as _i543;
import '../../features/auth/domain/repo/register_repo.dart' as _i937;
import '../../features/auth/domain/repo/reset_password_repo.dart' as _i594;
import '../../features/auth/domain/repo/sent_otp.dart' as _i526;
import '../../features/auth/domain/repo/verify_otp_repo.dart' as _i1030;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/sent_otp_use_case.dart' as _i556;
import '../../features/auth/domain/usecases/verify_otp_usecase.dart' as _i503;
import '../../features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart'
    as _i716;
import '../../features/auth/presentation/viewmodels/register_viewmodel/register_cubit.dart'
    as _i31;
import '../../features/auth/presentation/viewmodels/reset_password_viewmodel/reset_password_cubit.dart'
    as _i113;
import '../../features/auth/presentation/viewmodels/sent_otp_viewmodel/sent_otp_cubit.dart'
    as _i250;
import '../../features/auth/presentation/viewmodels/verify_otp_viewmode/verify_otp_cubit.dart'
    as _i467;
import '../../features/home/data/data_sources/services_data_sources.dart'
    as _i459;
import '../../features/home/data/data_sources/user_profile_data_sources.dart'
    as _i885;
import '../../features/home/data/data_sources_impl/services_data_sources_impl.dart'
    as _i952;
import '../../features/home/data/data_sources_impl/user_profile_sources_impl.dart'
    as _i909;
import '../../features/home/data/repo_impl/services_repo_impl.dart' as _i438;
import '../../features/home/data/repo_impl/user_profile_repo_impl.dart'
    as _i497;
import '../../features/home/domain/repo/services_repo.dart' as _i118;
import '../../features/home/domain/repo/user_profile_repo.dart' as _i250;
import '../../features/home/domain/usecases/services_usecase.dart' as _i463;
import '../../features/home/domain/usecases/user_profile_use_case.dart'
    as _i1044;
import '../../features/home/presentation/viewmodels/my_balance_viewmodel/my_balance_cubit.dart'
    as _i259;
import '../../features/home/presentation/viewmodels/services_viewmodel/services_cubit.dart'
    as _i239;
import '../../features/home/presentation/viewmodels/user_profile_view_model/user_profile_cubit.dart'
    as _i315;
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
    gh.factory<_i459.ServicesDataSources>(
      () => _i952.ServicesDataSourcesImpl(apiService: gh<_i680.ApiService>()),
    );
    gh.factory<_i466.LoginDataSource>(
      () => _i785.LoginDataSourceImpl(gh<_i680.ApiService>()),
    );
    gh.factory<_i398.VerifyOtpDataSource>(
      () => _i1070.VerifyOtpDataSourcesImpl(gh<_i680.ApiService>()),
    );
    gh.factory<_i575.SentOtpDataSource>(
      () => _i400.SentOtpDataSourcesImpl(gh<_i680.ApiService>()),
    );
    gh.factory<_i956.ResetPasswordDataSource>(
      () => _i753.ResetPasswordDataSourcesImpl(gh<_i680.ApiService>()),
    );
    gh.factory<_i543.LoginRepo>(
      () => _i204.LoginRepoImpl(gh<_i466.LoginDataSource>()),
    );
    gh.factory<_i1030.VerifyOtpRepo>(
      () => _i214.VerifyOtpRepoImpl(gh<_i398.VerifyOtpDataSource>()),
    );
    gh.factory<_i594.ResetPasswordRepo>(
      () => _i653.ResetPasswordRepoImpl(gh<_i956.ResetPasswordDataSource>()),
    );
    gh.factory<_i474.ResetPasswordUsecase>(
      () => _i474.ResetPasswordUsecase(gh<_i594.ResetPasswordRepo>()),
    );
    gh.factory<_i526.SentOtpRepo>(
      () => _i1020.SentOtpRepoImpl(gh<_i575.SentOtpDataSource>()),
    );
    gh.factory<_i885.MyBalanceDataSources>(
      () => _i909.MyBalanceDataSourcesImpl(apiService: gh<_i680.ApiService>()),
    );
    gh.factory<_i503.VerifyOtpUsecase>(
      () => _i503.VerifyOtpUsecase(gh<_i1030.VerifyOtpRepo>()),
    );
    gh.factory<_i885.UserProfileDataSources>(
      () =>
          _i909.UserProfileDataSourcesImpl(apiService: gh<_i680.ApiService>()),
    );
    gh.factory<_i484.RegisterDataSources>(
      () => _i525.RegisterDataSorucesImpl(apiService: gh<_i680.ApiService>()),
    );
    gh.factory<_i118.ServicesRepo>(
      () => _i438.ServicesRepoImpl(
        servicesDataSources: gh<_i459.ServicesDataSources>(),
      ),
    );
    gh.factory<_i467.VerifyOtpCubit>(
      () => _i467.VerifyOtpCubit(gh<_i503.VerifyOtpUsecase>()),
    );
    gh.factory<_i113.ResetPasswordCubit>(
      () => _i113.ResetPasswordCubit(gh<_i474.ResetPasswordUsecase>()),
    );
    gh.factory<_i188.LoginUsecase>(
      () => _i188.LoginUsecase(gh<_i543.LoginRepo>()),
    );
    gh.factory<_i463.ServicesUsecase>(
      () => _i463.ServicesUsecase(servicesRepo: gh<_i118.ServicesRepo>()),
    );
    gh.factory<_i250.MyBalanceRepo>(
      () => _i497.MyBalanceRepoImpl(gh<_i885.MyBalanceDataSources>()),
    );
    gh.factory<_i250.UserProfileRepo>(
      () => _i497.UserProfileRepoImpl(gh<_i885.UserProfileDataSources>()),
    );
    gh.factory<_i556.SentOtpUseCase>(
      () => _i556.SentOtpUseCase(gh<_i526.SentOtpRepo>()),
    );
    gh.factory<_i1044.UserProfileUseCase>(
      () => _i1044.UserProfileUseCase(gh<_i250.UserProfileRepo>()),
    );
    gh.factory<_i239.ServicesCubit>(
      () => _i239.ServicesCubit(gh<_i463.ServicesUsecase>()),
    );
    gh.factory<_i937.RegisterRepo>(
      () => _i1058.RegisterRepoImpl(
        registerDataSources: gh<_i484.RegisterDataSources>(),
      ),
    );
    gh.factory<_i1044.MyBalanceUseCase>(
      () => _i1044.MyBalanceUseCase(gh<_i250.MyBalanceRepo>()),
    );
    gh.factory<_i259.MyBalanceCubit>(
      () => _i259.MyBalanceCubit(gh<_i1044.MyBalanceUseCase>()),
    );
    gh.factory<_i716.LoginCubit>(
      () => _i716.LoginCubit(gh<_i188.LoginUsecase>()),
    );
    gh.factory<_i250.SentOtpCubit>(
      () => _i250.SentOtpCubit(gh<_i556.SentOtpUseCase>()),
    );
    gh.factory<_i315.UserProfileCubit>(
      () => _i315.UserProfileCubit(gh<_i1044.UserProfileUseCase>()),
    );
    gh.factory<_i941.RegisterUsecase>(
      () => _i941.RegisterUsecase(registerRepo: gh<_i937.RegisterRepo>()),
    );
    gh.factory<_i31.RegisterCubit>(
      () => _i31.RegisterCubit(gh<_i941.RegisterUsecase>()),
    );
    return this;
  }
}

class _$DioModule extends _i784.DioModule {}
