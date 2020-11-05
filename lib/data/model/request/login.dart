class Login {
  String userId;
  String passwd;
  int companyCode;
  String pushToken;
  String deviceModel;
  String osType;

  Login(
      {this.userId,
      this.passwd,
      this.companyCode,
      this.pushToken,
      this.deviceModel,
      this.osType});

  Login fromJson(Map<String, dynamic> json) {
    return Login(
      userId: json['userId'] as String,
      passwd: json['passwd'] as String,
      companyCode: json['companyCode'] as int,
      pushToken: json['pushToken'] as String,
      deviceModel: json['deviceModel'] as String,
      osType: json['osType'] as String,
    );
    // userId = json['userId'];
    // passwd = json['passwd'];
    // companyCode = json['companyCode'];
    // pushToken = json['pushToken'];
    // deviceModel = json['deviceModel'];
    // osType = json['osType'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': this.userId,
        'passwd': this.passwd,
        'companyCode': this.companyCode,
        'pushToken': this.pushToken,
        'deviceModel': this.deviceModel,
        'osType': this.osType,
      };
}
