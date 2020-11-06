import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/constant/asset_constant.dart';
import 'package:flutter_dio/constant/common_constant.dart';
import 'package:flutter_dio/data/model/response/company.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:flutter_dio/view/home/home_view.dart';
import 'package:flutter_dio/view/login/login_view_model.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _loginViewModel;
  ProgressDialog _progressDialog;

  final _formKey = GlobalKey<FormState>();
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  List<Company> companyList = List<Company>();
  int _selectedCompany;

  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel();
    _progressDialog = ProgressDialog(context);
    _getCompanyList();
  }

  String requiredFieldValidator(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutofillGroup(
        child: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(32.0), children: [
            Padding(
                padding: EdgeInsets.only(top: 70),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(AssetConstant.LOGIN_LOGO),
                        Text("로그인",
                            style: const TextStyle(
                                color: const Color(0xff212121), fontSize: 33.0))
                      ],
                    )
                  ],
                )),
            SizedBox(height: 40),
            DropdownButton(
              items: companyList.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item.company),
                  value: item.companyCode,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCompany = value;
                });
              },
              value: _selectedCompany,
            ),
            TextFormField(
              validator: requiredFieldValidator,
              controller: _usernameTextController,
              autofillHints: [AutofillHints.username],
              decoration: InputDecoration(
                labelText: 'Username',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextFormField(
              validator: requiredFieldValidator,
              controller: _passwordTextController,
              autofillHints: [AutofillHints.password],
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            SizedBox(height: 16),
            RaisedButton(
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;
                _processLogin();
              },
              child: const Text('Login'),
            ),
          ]),
        ),
      ),
    );
  }

  _getCompanyList() async {
    await _loginViewModel.loginCompanyList();
    var companyResult = _loginViewModel.companyResult;
    if (companyResult.status == ApiStatus.COMPLETED) {
      setState(() {
        companyList = companyResult.data.companyList;
        _selectedCompany = companyList[0].companyCode;
      });
    }
  }

  _processLogin() async {
    await _progressDialog.show();
    await _loginViewModel.login(
        _usernameTextController.text,
        _passwordTextController.text,
        _selectedCompany,
        '',
        await _getDeviceModel(),
        CommonConstant.ANDROID);
    await _progressDialog.hide();
    var loginResult = _loginViewModel.loginResult;
    if (loginResult.status == ApiStatus.COMPLETED) {
      _loginViewModel.saveUserInfo(loginResult.data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  _getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.model;
    }
    return "";
  }
}
