import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather/src/core/constants.dart';

extension ResponseX on Response {
  bool get isSuccessful => statusCode != null && statusCode! ~/ 100 == 2;

  bool get isServerError => statusCode != null && statusCode! ~/ 100 == 5;

  bool get isUnauthorised => statusCode == kUnauthorisedStatusCode;

  bool get isForbidden => statusCode == kForbiddenStatusCode;
}

extension DioErrorX on DioError {
  String get reasonPhrase {
    if (error is SocketException) {
      return kNoInternetMessage;
    }
    return message;
  }
}
