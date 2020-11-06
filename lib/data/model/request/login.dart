class LoginRequest {
  String userId;
  String passwd;
  int companyCode;
  String pushToken;
  String deviceModel;
  String osType;

  LoginRequest(
      {this.userId,
      this.passwd,
      this.companyCode,
      this.pushToken,
      this.deviceModel,
      this.osType});

  LoginRequest fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      userId: json['userId'] as String,
      passwd: json['passwd'] as String,
      companyCode: json['companyCode'] as int,
      pushToken: json['pushToken'] as String,
      deviceModel: json['deviceModel'] as String,
      osType: json['osType'] as String,
    );
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
