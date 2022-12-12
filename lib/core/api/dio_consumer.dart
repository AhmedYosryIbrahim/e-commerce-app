import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:store_task/core/api/status_code.dart';
import '../errors/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'package:store_task/injector.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client.options
      ..baseUrl = Endpoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = true;

    client.interceptors.add(di.sl<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future delete(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await client.delete(path, queryParameters: queryParameters);
      return _handleResponseJson(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseJson(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Map<String, dynamic>? body}) async {
    try {
      final response = await client.post(path,
          queryParameters: queryParameters,
          data: isFormData ? FormData.fromMap(body!) : body);
      return _handleResponseJson(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body}) async {
    try {
      final response =
          await client.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseJson(response);
    } on DioError catch (e) {
      throw _handleDioError(e);
    }
  }

  dynamic _handleResponseJson(Response response) {
    return jsonDecode(response.data.toString());
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw BadRequestException(error.response?.data);
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw UnauthorizedException(error.response?.data);
          case StatusCode.notFound:
            throw NotFoundException(error.response?.data);
          case StatusCode.conflict:
            throw ConflictException(error.response?.data);
          case StatusCode.unProcessableEntity:
            throw UnProcessableEntityException(error.response?.data);
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
          default:
            throw const FetchDataException();
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetException();
    }
  }
}
