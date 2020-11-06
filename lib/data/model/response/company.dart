class Company {
  String company;
  int companyCode;

  Company({
    this.company,
    this.companyCode,
  });

  Company fromJson(Map<String, dynamic> json) {
    return Company(
        company: json['company'] as String,
        companyCode: json['companyCode'] as int);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'company': this.company,
        'companyCode': this.companyCode
      };
}

class CompanyList {
  List<Company> companyList;

  CompanyList({this.companyList});

  CompanyList fromJson(Map<String, dynamic> json) {
    if (json['companyList'] != null) {
      companyList = List<Company>();
      json['companyList'].forEach((v) {
        companyList.add(Company().fromJson(v));
      });
    }
    return CompanyList(companyList: companyList);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'companyList': this.companyList};
}
