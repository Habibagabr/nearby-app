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
import 'package:near_buy_gp/core/location/data/datasource/location_service.dart'
    as _i342;
import 'package:near_buy_gp/core/location/data/datasource/location_service_impl.dart'
    as _i293;
import 'package:near_buy_gp/core/location/data/repository/location_repositry_impl.dart'
    as _i417;
import 'package:near_buy_gp/core/location/domain/repository/location_repo.dart'
    as _i342;
import 'package:near_buy_gp/core/location/domain/usecases/get_current_location.dart'
    as _i1069;
import 'package:near_buy_gp/core/location/domain/usecases/initialize_location_usecase.dart'
    as _i790;
import 'package:near_buy_gp/core/location/domain/usecases/watch%20_GPS_servicestatus_usecase.dart'
    as _i262;
import 'package:near_buy_gp/core/location/domain/usecases/watch_user_location%20_usecase.dart'
    as _i1059;
import 'package:near_buy_gp/core/location/presentation/bloc/location_bloc.dart'
    as _i835;
import 'package:near_buy_gp/core/network/interceptors/error_interceptor.dart'
    as _i100;
import 'package:near_buy_gp/core/network/interceptors/logger_interceptor.dart'
    as _i852;
import 'package:near_buy_gp/core/network/interceptors/request_interceptor.dart'
    as _i617;
import 'package:near_buy_gp/core/network/sessionManager/session_manager_implementation.dart'
    as _i850;
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart'
    as _i447;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/data/dataSource/login_remote_datasource.dart'
    as _i490;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/data/dataSource/login_remote_datasource_interface.dart'
    as _i895;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/data/repository/login_repository.dart'
    as _i529;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/repository/login_repository_interface.dart'
    as _i363;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/usecases/login_usecase.dart'
    as _i600;
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/presentation/bloc/login_screen_bloc.dart'
    as _i292;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/dataSource/register_remote_datasource.dart'
    as _i34;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/dataSource/register_remote_datasource_interface.dart'
    as _i732;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/repository/register_repository.dart'
    as _i757;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/repositories/register_repo_interface.dart'
    as _i514;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/usecases/register_usecase.dart'
    as _i184;
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/presentation/bloc/signup_screen_bloc.dart'
    as _i764;
import 'package:near_buy_gp/features/homeScreen/data/datasource/home_remote_service.dart'
    as _i859;
import 'package:near_buy_gp/features/homeScreen/data/datasource/home_remote_service_impl.dart'
    as _i217;
import 'package:near_buy_gp/features/homeScreen/data/repository/home_repository_impl.dart'
    as _i1041;
import 'package:near_buy_gp/features/homeScreen/domain/repository/home_repository.dart'
    as _i269;
import 'package:near_buy_gp/features/homeScreen/domain/usecases/get_nearby_places.dart'
    as _i716;
import 'package:near_buy_gp/features/homeScreen/ui/bloc/home_bloc.dart'
    as _i715;
import 'package:near_buy_gp/features/mapScreen/data/map_remote_data_source_service/map_remote_data_source_service.dart'
    as _i659;
import 'package:near_buy_gp/features/mapScreen/data/map_remote_data_source_service/map_remote_data_source_service_imp.dart'
    as _i819;
import 'package:near_buy_gp/features/mapScreen/data/mapRepository/map_repository_impl.dart'
    as _i467;
import 'package:near_buy_gp/features/mapScreen/domain/repositories/mapRepository.dart'
    as _i576;
import 'package:near_buy_gp/features/mapScreen/domain/usecases/get_nearby_pins.dart'
    as _i876;
import 'package:near_buy_gp/features/mapScreen/presentation/bloc/map_bloc.dart'
    as _i809;
import 'package:near_buy_gp/features/place_screen/data/dataSource/places_remote_data_source.dart'
    as _i90;
import 'package:near_buy_gp/features/place_screen/data/dataSource/places_remote_data_source_impl.dart'
    as _i801;
import 'package:near_buy_gp/features/place_screen/data/repository/place_repository_impl.dart'
    as _i354;
import 'package:near_buy_gp/features/place_screen/domain/repository/place_repository.dart'
    as _i434;
import 'package:near_buy_gp/features/place_screen/domain/usecase/check_user_register.dart'
    as _i624;
import 'package:near_buy_gp/features/place_screen/domain/usecase/get_initial_place_data_usecase.dart'
    as _i809;
import 'package:near_buy_gp/features/place_screen/domain/usecase/get_place_items_usecase.dart'
    as _i166;
import 'package:near_buy_gp/features/place_screen/presentation/bloc/place_bloc.dart'
    as _i496;
import 'package:near_buy_gp/features/profileScreen/presentation/ui/bloc/profile_bloc.dart'
    as _i335;
import 'package:near_buy_gp/features/searchScreen/data/datasource/search_remote_service.dart'
    as _i1044;
import 'package:near_buy_gp/features/searchScreen/data/datasource/search_remote_service_impl.dart'
    as _i493;
import 'package:near_buy_gp/features/searchScreen/data/repository/search_repository_impl.dart'
    as _i542;
import 'package:near_buy_gp/features/searchScreen/domain/repository/search_repository.dart'
    as _i980;
import 'package:near_buy_gp/features/searchScreen/domain/usecases/auto_complete_usecase.dart'
    as _i330;
import 'package:near_buy_gp/features/searchScreen/domain/usecases/serach_usecase.dart'
    as _i354;
import 'package:near_buy_gp/features/searchScreen/presentation/bloc/search_bloc.dart'
    as _i117;

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
    gh.lazySingleton<_i342.LocationService>(() => _i293.LocationServiceImpl());
    gh.lazySingleton<_i447.SessionManager>(
      () => _i850.SessionManagerImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i617.RequestInterceptor>(
      () => _i617.RequestInterceptor(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i342.LocationRepository>(
      () => _i417.LocationRepositoryImpl(gh<_i342.LocationService>()),
    );
    gh.lazySingleton<_i624.CheckUserRegister>(
      () => _i624.CheckUserRegister(sessionManager: gh<_i447.SessionManager>()),
    );
    gh.factory<_i335.ProfileBloc>(
      () => _i335.ProfileBloc(sessionManager: gh<_i447.SessionManager>()),
    );
    gh.lazySingleton<_i1069.GetCurrentLocation>(
      () => _i1069.GetCurrentLocation(gh<_i342.LocationRepository>()),
    );
    gh.lazySingleton<_i790.InitializeLocation>(
      () => _i790.InitializeLocation(gh<_i342.LocationRepository>()),
    );
    gh.lazySingleton<_i262.WatchGpsStatus>(
      () => _i262.WatchGpsStatus(gh<_i342.LocationRepository>()),
    );
    gh.lazySingleton<_i1059.WatchUserLocation>(
      () => _i1059.WatchUserLocation(gh<_i342.LocationRepository>()),
    );
    gh.factory<_i835.LocationBloc>(
      () => _i835.LocationBloc(
        gh<_i790.InitializeLocation>(),
        gh<_i1059.WatchUserLocation>(),
        gh<_i262.WatchGpsStatus>(),
        gh<_i1069.GetCurrentLocation>(),
      ),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(
        gh<_i361.BaseOptions>(),
        gh<_i852.LoggerInterceptor>(),
        gh<_i617.RequestInterceptor>(),
        gh<_i100.ErrorInterceptor>(),
      ),
    );
    gh.lazySingleton<_i659.MapRemoteDataSource>(
      () => _i819.MapRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1044.SearchRemoteService>(
      () => _i493.SearchRemoteServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i732.RegisterRemoteDataSource>(
      () => _i34.RegisterRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i859.HomeRemoteService>(
      () => _i217.HomeRemoteServiceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i895.LoginRemoteDataSource>(
      () => _i490.LoginRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i90.PlacesRemoteDataSource>(
      () => _i801.PlacesRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i576.MapRepository>(
      () => _i467.MapRepositoryImpl(
        mapRemoteDataSource: gh<_i659.MapRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i269.HomeRepository>(
      () => _i1041.HomeRepositoryImpl(gh<_i859.HomeRemoteService>()),
    );
    gh.lazySingleton<_i980.SearchRepository>(
      () => _i542.SearchRepositoryImpl(gh<_i1044.SearchRemoteService>()),
    );
    gh.lazySingleton<_i514.RegisterRepositoryInterface>(
      () => _i757.AuthRepositoryImpl(gh<_i732.RegisterRemoteDataSource>()),
    );
    gh.factory<_i363.LoginRepository>(
      () => _i529.LoginRepositoryImp(gh<_i895.LoginRemoteDataSource>()),
    );
    gh.lazySingleton<_i330.AutoCompleteUseCase>(
      () => _i330.AutoCompleteUseCase(gh<_i980.SearchRepository>()),
    );
    gh.lazySingleton<_i354.SearchUseCase>(
      () => _i354.SearchUseCase(gh<_i980.SearchRepository>()),
    );
    gh.lazySingleton<_i434.PlaceRepository>(
      () => _i354.PlaceRepositoryImpl(gh<_i90.PlacesRemoteDataSource>()),
    );
    gh.lazySingleton<_i716.GetNearbyPlacesUseCase>(
      () => _i716.GetNearbyPlacesUseCase(gh<_i269.HomeRepository>()),
    );
    gh.lazySingleton<_i876.GetNearbyPinsUseCase>(
      () => _i876.GetNearbyPinsUseCase(repository: gh<_i576.MapRepository>()),
    );
    gh.lazySingleton<_i184.RegisterUseCase>(
      () => _i184.RegisterUseCase(
        gh<_i514.RegisterRepositoryInterface>(),
        gh<_i447.SessionManager>(),
      ),
    );
    gh.factory<_i764.SignupScreenBloc>(
      () => _i764.SignupScreenBloc(gh<_i184.RegisterUseCase>()),
    );
    gh.factory<_i117.SearchBloc>(
      () => _i117.SearchBloc(
        gh<_i354.SearchUseCase>(),
        gh<_i330.AutoCompleteUseCase>(),
      ),
    );
    gh.lazySingleton<_i600.LoginUseCase>(
      () => _i600.LoginUseCase(
        gh<_i363.LoginRepository>(),
        gh<_i447.SessionManager>(),
      ),
    );
    gh.factory<_i292.LoginScreenBloc>(
      () => _i292.LoginScreenBloc(gh<_i600.LoginUseCase>()),
    );
    gh.lazySingleton<_i809.MapBloc>(
      () =>
          _i809.MapBloc(getNearbyPinsUseCase: gh<_i876.GetNearbyPinsUseCase>()),
    );
    gh.lazySingleton<_i809.LoadPlaceScreenUseCase>(
      () => _i809.LoadPlaceScreenUseCase(gh<_i434.PlaceRepository>()),
    );
    gh.lazySingleton<_i166.LoadPlaceItemsUseCase>(
      () => _i166.LoadPlaceItemsUseCase(gh<_i434.PlaceRepository>()),
    );
    gh.lazySingleton<_i715.HomeBloc>(
      () => _i715.HomeBloc(gh<_i716.GetNearbyPlacesUseCase>()),
    );
    gh.factory<_i496.PlaceBloc>(
      () => _i496.PlaceBloc(
        loadPlaceScreen: gh<_i809.LoadPlaceScreenUseCase>(),
        loadPlaceItems: gh<_i166.LoadPlaceItemsUseCase>(),
        checkUserRegister: gh<_i624.CheckUserRegister>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1038.RegisterModule {}
