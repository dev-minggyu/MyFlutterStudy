import 'package:flutter/material.dart';
import 'package:flutter_dio/data/model/response/login.dart';
import 'package:flutter_dio/view/home/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _homeViewModel;
  LoginResponse _userInfo;

  @override
  void initState() {
    super.initState();
    _homeViewModel = HomeViewModel();
    _userInfo = LoginResponse();
    loadUserInfo();
  }

  loadUserInfo() async {
    var userInfo = await _homeViewModel.loadUserInfo();
    setState(() {
      _userInfo = userInfo;
    });
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
      body: ListView(
        children: <Widget>[
          ListTile(
            //leading. 타일 앞에 표시되는 위젯. 참고로 타일 뒤에는 trailing 위젯으로 사용 가능
            leading: Icon(Icons.map),
            title: Text(_userInfo.name ?? ""),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          )
        ],
      ),
    );
  }
}
