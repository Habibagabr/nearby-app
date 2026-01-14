// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:near_buy_gp/core/di/register_module.dart' as _i1038;
import 'package:near_buy_gp/core/network/interceptors/auth_interceptor.dart'
    as _i434;
import 'package:near_buy_gp/core/network/interceptors/error_interceptor.dart'
    as _i100;
import 'package:near_buy_gp/core/network/interceptors/logger_interceptor.dart'
    as _i852;
import 'package:near_buy_gp/core/network/sessionManager/session_manager_implementation.dart'
    as _i850;
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart'
    as _i447;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/dataSource/auth_remote_datasource.dart'
    as _i914;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/dataSource/auth_remote_datasource_interface.dart'
    as _i935;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/repository/authentication_repository.dart'
    as _i611;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/repositories/auth_repo_interface.dart'
    as _i571;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/usecases/register_usecase.dart'
    as _i184;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/presentation/bloc/signup_screen_bloc.dart'
    as _i764;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(() => registerModule.storage);
    gh.lazySingleton<_i361.BaseOptions>(() => registerModule.options);
    gh.lazySingleton<_i100.ErrorInterceptor>(() => _i100.ErrorInterceptor());
    gh.lazySingleton<_i852.LoggerInterceptor>(() => _i852.LoggerInterceptor());
    gh.lazySingleton<_i447.SessionManager>(
      () => _i850.SessionManagerImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i434.AuthInterceptor>(
      () => _i434.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i361.BaseOptions>(),
        gh<_i852.LoggerInterceptor>(),
        gh<_i434.AuthInterceptor>(),
        gh<_i100.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i935.AuthRemoteDataSource>(
      () => _i914.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i571.AuthRepositoryInterface>(
      () => _i611.AuthRepositoryImpl(gh<_i935.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i184.RegisterUseCase>(
      () => _i184.RegisterUseCase(
        gh<_i571.AuthRepositoryInterface>(),
        gh<_i447.SessionManager>(),
      ),
    );
    gh.factory<_i764.SignupScreenBloc>(
      () => _i764.SignupScreenBloc(gh<_i184.RegisterUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i1038.RegisterModule {}
