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
import 'package:near_buy_gp/core/network/interceptors/logger_interceptor.dart'
    as _i852;

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
    gh.lazySingleton<_i852.LoggerInterceptor>(() => _i852.LoggerInterceptor());
    gh.factory<_i434.AuthInterceptor>(
      () => _i434.AuthInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i361.BaseOptions>(),
        gh<_i852.LoggerInterceptor>(),
        gh<_i434.AuthInterceptor>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1038.RegisterModule {}
