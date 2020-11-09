import 'dart:convert';

import 'package:flutter_dio/constant/network_constant.dart';
import 'package:http/http.dart' as _http;

class NetworkHelper {
  get(String url, Map<String, String> headers) async {
    final response =
        await _http.get(NetworkConstant.BASE_URL + url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  getWithParam(String url, Map<String, dynamic> params) async {
    final response = await _http.get(NetworkConstant.BASE_URL + url);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  post(String url, Map<String, dynamic> body) async {
    final response = await _http.post(NetworkConstant.BASE_URL + url,
        body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  put(String url) async {
    final response = await _http.put(NetworkConstant.BASE_URL + url);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }

  delete(String url) async {
    final response = await _http.delete(NetworkConstant.BASE_URL + url);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error');
    }
  }
}

class ResponseCode {
  static int success = 200;
  static int unknown = 998;
  static int unavailableInternet = 999;
}

/// Single final Object
final networkHelper = NetworkHelper();
