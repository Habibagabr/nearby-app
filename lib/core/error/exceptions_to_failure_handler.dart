import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:near_buy_gp/core/error/app_failure.dart';

class ExceptionsToFailureHandler {
  ExceptionsToFailureHandler._();

  // exception could be a DioException, a TypeError, or even a Manual Error , so we make it dynamic
  static AppFailure handler(dynamic exception) {
    if (exception is DioException) {
      // manual safer handling
      switch (exception.type) {
        // they are estimated in the BaseOptions
        case DioExceptionType
            .connectionTimeout: // couldn't connected to the server
        case DioExceptionType
            .sendTimeout: // e.g : the app couldn't upload large data
        case DioExceptionType
            .receiveTimeout: // the server time for response is out
          return ServerFailure(
            serverFailureMessage: "Connection timed out. Please try again",
          );

        case DioExceptionType.badCertificate:
          return ServerFailure(
            serverFailureMessage: "Security certificate is invalid",
          );

        case DioExceptionType.badResponse:
          return ServerFailure(
            serverFailureMessage:
                exception.response?.data['message'] ??
                "Network error , please try again later",
          );

        case DioExceptionType.connectionError:
          return NetworkFailure(
            networkFailureMessage:
                "No Internet Connection , Check your Wi-Fi or network, then refresh the page",
          );

        case DioExceptionType.cancel:
          return CancelFailure(cancelFailureMessage: "user cancel the request");

        case DioExceptionType.unknown:
          return ServerFailure(
            serverFailureMessage: "Unknown error , please try again later",
          );
      }
    }
    return GeneralFailure(
      generalFailureMessage: "Something went wrong  , please try again later",
    );
  }
}
