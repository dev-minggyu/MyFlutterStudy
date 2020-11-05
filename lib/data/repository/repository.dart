import 'dart:convert';

import 'package:flutter_dio/data/model/request/login.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:flutter_dio/helper/network_helper.dart';

class Repository {
  static const LOGIN = 'login';
  static const POPULAR_MOVIES = 'movie/popular';

  login(String userId, String passwd, int companyCode, String pushToken,
      String deviceModel, String osType) async {
    try {
      var login = Login(
          userId: userId,
          passwd: passwd,
          companyCode: companyCode,
          pushToken: pushToken,
          osType: osType);
      final response = await networkHelper.post(LOGIN, login.toJson());
      return Result.returnResponse(
          response, Login().fromJson(jsonDecode(response.toString())));
    } catch (error, stacktrace) {
      print(error.toString());
      return Result.error(
          errCode: ResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }
}
