class DocumentCount {
  int ingCount;
  int doneCount;
  int returnCount;
  int approvalIngCount;
  int receiveCount;
  int futureIngCount;
  int afterIngCount;

  DocumentCount(
      {this.ingCount,
      this.doneCount,
      this.returnCount,
      this.approvalIngCount,
      this.receiveCount,
      this.futureIngCount,
      this.afterIngCount});

  DocumentCount test() {
    return DocumentCount(
        ingCount: 0,
        doneCount: 0,
        returnCount: 0,
        approvalIngCount: 0,
        receiveCount: 0,
        futureIngCount: 0,
        afterIngCount: 0);
  }

  DocumentCount fromJson(Map<String, dynamic> json) {
    return DocumentCount(
        ingCount: json['ingCount'] as int,
        doneCount: json['doneCount'] as int,
        returnCount: json['returnCount'] as int,
        approvalIngCount: json['approvalIngCount'] as int,
        receiveCount: json['receiveCount'] as int,
        futureIngCount: json['futureIngCount'] as int,
        afterIngCount: json['afterIngCount'] as int);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'ingCount': this.ingCount,
        'doneCount': this.doneCount,
        'returnCount': this.returnCount,
        'approvalIngCount': this.approvalIngCount,
        'receiveCount': this.receiveCount,
        'futureIngCount': this.futureIngCount,
        'afterIngCount': this.afterIngCount
      };
}
