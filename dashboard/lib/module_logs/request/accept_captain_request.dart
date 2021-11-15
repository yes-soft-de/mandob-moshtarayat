class AcceptCaptainRequest {
  String? captainID;
  num? salary;
  String? status;
  num? bounce;

  AcceptCaptainRequest({
      this.captainID, 
      this.salary, 
      this.status, 
      this.bounce});

  AcceptCaptainRequest.fromJson(dynamic json) {
    captainID = json['captainID'];
    salary = json['salary'];
    status = json['status'];
    bounce = json['bounce'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['captainID'] = captainID;
    map['salary'] = salary;
    map['status'] = status;
    map['bounce'] = bounce;
    return map;
  }

}