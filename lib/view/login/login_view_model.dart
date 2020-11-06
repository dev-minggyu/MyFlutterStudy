import 'package:flutter_dio/data/model/response/company.dart';
import 'package:flutter_dio/data/model/response/login.dart';
import 'package:flutter_dio/data/repository/repository.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel extends Model {
  Repository _repository = Repository();

  Result<LoginResponse> _loginResult = Result();

  Result<LoginResponse> get loginResult => _loginResult;

  login(String userId, String passwd, int companyCode, String pushToken,
      String deviceModel, String osType) async {
    _loginResult = Result.loading();
    notifyListeners();

    _loginResult = await _repository.login(
        userId, passwd, companyCode, pushToken, deviceModel, osType);
    notifyListeners();
  }

  Result<CompanyList> _companyResult = Result();

  Result<CompanyList> get companyResult => _companyResult;

  loginCompanyList() async {
    _companyResult = Result.loading();
    notifyListeners();

    _companyResult = await _repository.loginCompanyList();
    notifyListeners();
  }

  saveUserInfo(LoginResponse loginResponse) async {
    await _repository.saveUserInfo(loginResponse);
  }
}
