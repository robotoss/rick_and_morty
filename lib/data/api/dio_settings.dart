import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioSettings {
  DioSettings() {
    initialSettings();
  }

  static final mainServer = 'https://rickandmortyapi.com/';
  static final apiAddress = 'api/';

  Dio dio = Dio(
    BaseOptions(
      baseUrl: mainServer + apiAddress,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ),
  );

  void initialSettings() {
    final interceptors = dio.interceptors;

    interceptors.clear();

    interceptors.requestLock.lock();

    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          return handler.next(options); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
          // If you want to reject the request with a error message,
          // you can reject a `DioError` object eg: return `dio.reject(dioError)`
        },
        onError: (DioError error, handler) {
          if (error.type == DioErrorType.connectTimeout) {
            return handler.resolve(
              Response(
                statusCode: 400,
                statusMessage: 'Server do not answer',
                requestOptions: error.requestOptions,
              ),
            );
          } else if (error.message.contains('SocketException:')) {
            return handler.resolve(
              Response(
                statusCode: 400,
                statusMessage: 'No internet connection',
                requestOptions: error.requestOptions,
              ),
            );
          }
          return handler.next(error); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        },
      ),
    );

    // Add logs in Debug versions
    if (!kReleaseMode) {
      interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: true,
        ),
      );
    }

    interceptors.requestLock.unlock();
  }
}
