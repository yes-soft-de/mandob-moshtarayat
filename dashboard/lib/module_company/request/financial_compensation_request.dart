class FinancialCompensationRequest {
  int? id;
  int? kilometers;
  double? maxKilometerBonus;
  double? minKilometerBonus;

  FinancialCompensationRequest({
      this.id, 
      this.kilometers, 
      this.maxKilometerBonus, 
      this.minKilometerBonus});

  FinancialCompensationRequest.fromJson(dynamic json) {
    id = json['id'];
    kilometers = json['kilometers'];
    maxKilometerBonus = json['maxKilometerBonus'];
    minKilometerBonus = json['minKilometerBonus'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['kilometers'] = kilometers;
    map['maxKilometerBonus'] = maxKilometerBonus;
    map['minKilometerBonus'] = minKilometerBonus;
    return map;
  }

}