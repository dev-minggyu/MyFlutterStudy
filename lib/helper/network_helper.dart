import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dio/constant/network_constant.dart';

class NetworkHelper {
  Dio _dio;
  List<int> _certBytes;

  NetworkHelper() {
    BaseOptions options = BaseOptions(
        baseUrl: NetworkConstant.BASE_URL,
        receiveTimeout: NetworkConstant.TIMEOUT,
        connectTimeout: NetworkConstant.TIMEOUT);
    _dio = Dio(options);
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  setCertificate(Dio dio) async {
    if (_certBytes == null) {
      _certBytes = (await rootBundle.load('raw/cert.pem')).buffer.asInt8List();
    } else {
      return;
    }
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext sc = SecurityContext(withTrustedRoots: true);
      sc.setTrustedCertificatesBytes(_certBytes);
      HttpClient httpClient = HttpClient(context: sc);
      return httpClient;
    };
  }

  Future<Response<dynamic>> get(String url) async {
    await setCertificate(_dio);
    Response response;
    try {
      response = await _dio.get(url,
          options: Options(responseType: ResponseType.json));
      response.data = jsonDecode(response.toString());
    } on SocketException {
      response = Response();
      response.statusCode = ResponseCode.unavailableInternet;
      response.statusMessage = '';
    } on Exception {
      response = Response();
      response.statusCode = ResponseCode.unknown;
      response.statusMessage = '';
    }
    return response;
  }

  Future<Response<dynamic>> getWithParam(
      String url, Map<String, dynamic> params) async {
    await setCertificate(_dio);
    Response response;
    try {
      // final result = await InternetAddress.lookup('google.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      response = await _dio.get(url,
          queryParameters: params,
          options: Options(responseType: ResponseType.json));
      response.data = jsonDecode(response.toString());
      // }
    } on SocketException {
      response = Response();
      response.statusCode = ResponseCode.unavailableInternet;
      response.statusMessage = '';
    } on Exception {
      response = Response();
      response.statusCode = ResponseCode.unknown;
      response.statusMessage = '';
    }
    return response;
  }

  Future<Response> post(String url, Map<String, dynamic> params) async {
    await setCertificate(_dio);
    Response response;
    try {
      response = await _dio.post(url,
          data: params, options: Options(responseType: ResponseType.json));
      response.data = jsonDecode(response.toString());
    } on SocketException {
      response = Response();
      response.statusCode = ResponseCode.unavailableInternet;
      response.statusMessage = '';
    } on Exception {
      response = Response();
      response.statusCode = ResponseCode.unknown;
      response.statusMessage = '';
    }
    return response;
  }

  Future<Response> put(String url, Map<String, dynamic> params) async {
    await setCertificate(_dio);
    Response response = await _dio.put(url,
        data: params, options: Options(responseType: ResponseType.json));
    response.data = jsonDecode(response.toString());
    return response;
  }

  Future<Response> delete(String url, Map<String, dynamic> params) async {
    await setCertificate(_dio);
    Response response = await _dio.delete(url,
        data: params, options: Options(responseType: ResponseType.json));
    response.data = jsonDecode(response.toString());
    return response;
  }
}

class ResponseCode {
  static int success = 200;
  static int unknown = 998;
  static int unavailableInternet = 999;
}

/// Single final Object
final networkHelper = NetworkHelper();
