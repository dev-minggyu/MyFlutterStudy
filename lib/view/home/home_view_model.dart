import 'package:flutter_dio/data/model/request/login.dart';
import 'package:flutter_dio/data/repository/repository.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  Repository _repository = Repository();

  Result<LoginRequest> _loginResult = Result();

  Result<LoginRequest> get loginResult => _loginResult;

  login(String userId, String passwd, int companyCode, String pushToken,
      String deviceModel, String osType) async {
    _loginResult = Result.loading();
    notifyListeners();

    _loginResult = await _repository.login(
        userId, passwd, companyCode, pushToken, deviceModel, osType);
    notifyListeners();
  }

  loadUserInfo() async {
    return await _repository.loadUserInfo();
  }
}
