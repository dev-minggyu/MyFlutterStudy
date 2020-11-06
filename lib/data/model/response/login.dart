class LoginResponse {
  String accessToken;
  int enumber;
  String name;
  String rank;
  int rankCode;
  String position;
  int positionCode;
  String team;
  int teamCode;
  String company;
  int companyCode;
  bool isExistSign;

  LoginResponse(
      {this.accessToken,
      this.enumber,
      this.name,
      this.rank,
      this.rankCode,
      this.position,
      this.positionCode,
      this.team,
      this.teamCode,
      this.company,
      this.companyCode,
      this.isExistSign});

  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        accessToken: json['accessToken'] as String,
        enumber: json['enumber'] as int,
        name: json['name'] as String,
        rank: json['rank'] as String,
        rankCode: json['rankCode'] as int,
        position: json['position'] as String,
        positionCode: json['positionCode'] as int,
        team: json['team'] as String,
        teamCode: json['teamCode'] as int,
        company: json['company'] as String,
        companyCode: json['companyCode'] as int,
        isExistSign: json['isExistSign'] as bool);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': this.accessToken,
        'enumber': this.enumber,
        'name': this.name,
        'rank': this.rank,
        'rankCode': this.rankCode,
        'position': this.position,
        'positionCode': this.positionCode,
        'team': this.team,
        'teamCode': this.teamCode,
        'company': this.company,
        'companyCode': this.companyCode,
        'isExistSign': this.isExistSign
      };
}
