import 'package:flutter_dio/constant/common_constant.dart';
import 'package:flutter_dio/data/model/request/login.dart';
import 'package:flutter_dio/data/model/response/company.dart';
import 'package:flutter_dio/data/model/response/login.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:flutter_dio/helper/network_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Repository {
  static const LOGIN = 'login';
  static const LOGIN_COMPANY_LIST = 'login/company';

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  login(String userId, String passwd, int companyCode, String pushToken,
      String deviceModel, String osType) async {
    try {
      var login = LoginRequest(
          userId: userId,
          passwd: passwd,
          companyCode: companyCode,
          pushToken: pushToken,
          deviceModel: deviceModel,
          osType: osType);
      final response = await networkHelper.post(LOGIN, login.toJson());
      return Result.returnResponse(
          response, LoginResponse().fromJson(response['resultData']));
    } catch (error, stacktrace) {
      print(error.toString());
      return Result.error(
          errCode: ResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  loginCompanyList() async {
    try {
      final response = await networkHelper.get(LOGIN_COMPANY_LIST);
      return Result.returnResponse(
          response, CompanyList().fromJson(response['resultData']));
    } catch (error, stacktrace) {
      print(error.toString());
      return Result.error(
          errCode: ResponseCode.unknown,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }

  saveUserInfo(LoginResponse loginResponse) async {
    await _storage.write(
        key: CommonConstant.KEY_ACCESS_TOKEN, value: loginResponse.accessToken);
    await _storage.write(
        key: CommonConstant.KEY_ENUMBER,
        value: loginResponse.enumber.toString());
    await _storage.write(
        key: CommonConstant.KEY_NAME, value: loginResponse.name);
    await _storage.write(
        key: CommonConstant.KEY_RANK, value: loginResponse.rank);
    await _storage.write(
        key: CommonConstant.KEY_RANK_CODE,
        value: loginResponse.rankCode.toString());
    await _storage.write(
        key: CommonConstant.KEY_POSITION, value: loginResponse.position);
    await _storage.write(
        key: CommonConstant.KEY_POSITION_CODE,
        value: loginResponse.positionCode.toString());
    await _storage.write(
        key: CommonConstant.KEY_TEAM, value: loginResponse.team);
    await _storage.write(
        key: CommonConstant.KEY_TEAM_CODE,
        value: loginResponse.teamCode.toString());
    await _storage.write(
        key: CommonConstant.KEY_COMPANY, value: loginResponse.company);
    await _storage.write(
        key: CommonConstant.KEY_COMPANY_CODE,
        value: loginResponse.companyCode.toString());
  }

  loadUserInfo() async {
    var loginResponse = LoginResponse();
    loginResponse.accessToken =
        await _storage.read(key: CommonConstant.KEY_ACCESS_TOKEN);
    loginResponse.enumber =
        int.parse(await _storage.read(key: CommonConstant.KEY_ENUMBER));
    loginResponse.name = await _storage.read(key: CommonConstant.KEY_NAME);
    loginResponse.rank = await _storage.read(key: CommonConstant.KEY_RANK);
    loginResponse.rankCode =
        int.parse(await _storage.read(key: CommonConstant.KEY_RANK_CODE));
    loginResponse.position =
        await _storage.read(key: CommonConstant.KEY_POSITION);
    loginResponse.positionCode =
        int.parse(await _storage.read(key: CommonConstant.KEY_POSITION_CODE));
    loginResponse.team = await _storage.read(key: CommonConstant.KEY_TEAM);
    loginResponse.teamCode =
        int.parse(await _storage.read(key: CommonConstant.KEY_TEAM_CODE));
    loginResponse.company =
        await _storage.read(key: CommonConstant.KEY_COMPANY);
    loginResponse.companyCode =
        int.parse(await _storage.read(key: CommonConstant.KEY_COMPANY_CODE));
    return loginResponse;
  }
}
