import 'package:near_buy_gp/core/error/app_failure.dart';

String? getErrorImage(AppFailure failure){
  return switch (failure) {
    NetworkFailure() => "assets/images/network_error.webp",
    ServerFailure() => "assets/images/cloud_error.webp",
    GeneralFailure() => "assets/images/cloud_error.webp",
    CancelFailure() => null,
  };
}