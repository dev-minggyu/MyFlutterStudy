import 'package:flutter/material.dart';
import 'package:flutter_dio/constant/asset_constant.dart';
import 'package:flutter_dio/data/model/response/document_count.dart';
import 'package:flutter_dio/data/model/response/login.dart';
import 'package:flutter_dio/data/result.dart';
import 'package:flutter_dio/utils/hex_color.dart';
import 'package:flutter_dio/view/home/home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel _homeViewModel;
  LoginResponse _userInfo;
  DocumentCount _documentCount = DocumentCount();

  Image logoImage;
  Image logoImage2;

  @override
  void initState() {
    super.initState();
    logoImage = Image.asset(AssetConstant.LOGIN_LOGO);
    logoImage2 = Image.asset(AssetConstant.MAIN_LOGO);

    _homeViewModel = HomeViewModel();
    _userInfo = LoginResponse();
    _documentCount = DocumentCount().test();
    loadUserInfo();
    _getDocumentCount();
  }

  loadUserInfo() async {
    var userInfo = await _homeViewModel.loadUserInfo();
    setState(() {
      _userInfo = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("f4f4f5"),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: Row(
              children: [
                Column(
                  children: [
                    logoImage,
                    Text("전자문서 결재 서비스",
                        style: TextStyle(
                            color: Color(0xff212121), fontSize: 23.0)),
                  ],
                ),
                Spacer(),
                logoImage2
              ],
            ),
          ),
          SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: [
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("상신",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.ingCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
              Divider(height: 1),
              FlatButton(
                color: Colors.white,
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("미결",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.approvalIngCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
              Divider(height: 1),
              FlatButton(
                color: Colors.white,
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("예결",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.futureIngCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
              Divider(height: 1),
              FlatButton(
                color: Colors.white,
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("기결",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.doneCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
              Divider(height: 1),
              FlatButton(
                color: Colors.white,
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("반려",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.returnCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
              Divider(height: 1),
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                onPressed: () {},
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text("수신",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff69b4ef)),
                        padding: EdgeInsets.all(5),
                        child: Text(_documentCount.receiveCount.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0)))
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  _getDocumentCount() async {
    await _homeViewModel.documentCount();
    var documentCountResult = _homeViewModel.documentCountResult;
    if (documentCountResult.status == ApiStatus.COMPLETED) {
      setState(() {
        _documentCount = documentCountResult.data;
      });
    }
  }
}
