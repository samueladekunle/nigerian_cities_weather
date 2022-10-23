import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:weather/src/core/constants.dart';
import 'package:weather/src/core/extensions/dio_extensions.dart';

class AppException implements Exception {
  final int? statusCode;
  final String message;

  const AppException({
    this.statusCode,
    this.message = kDefaultErrorMessage,
  });

  factory AppException.fromDioError(DioError e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final statusMessage = response?.statusMessage ?? kDefaultErrorMessage;

    if (response != null) {
      if (response.isServerError) {
        return ServerException(message: statusMessage, statusCode: statusCode);
      } else if (response.isUnauthorised) {
        return UnauthorisedException(message: statusMessage);
      } else if (response.isForbidden) {
        return ForbiddenException(message: statusMessage);
      }
      return AppException(message: statusMessage, statusCode: statusCode);
    }

    return AppException(message: e.reasonPhrase, statusCode: statusCode);
  }

  factory AppException.fromPlatformException(PlatformException exception) {
    return AppException(
      statusCode: int.tryParse(exception.code),
      message: exception.message ?? '',
    );
  }

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException({
    required super.message,
    required super.statusCode,
  });
}

class UnauthorisedException extends AppException {
  const UnauthorisedException({
    required super.message,
    super.statusCode = kUnauthorisedStatusCode,
  });
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    required super.message,
    super.statusCode = kForbiddenStatusCode,
  });
}

class LocationNotEnabledException extends AppException {
  const LocationNotEnabledException({
    required super.message,
  });
}

class LocationPermissionDeniedException extends AppException {
  const LocationPermissionDeniedException({
    required super.message,
  });
}

class LocationPermissionDeniedForeverException extends AppException {
  const LocationPermissionDeniedForeverException({
    required super.message,
  });
}
