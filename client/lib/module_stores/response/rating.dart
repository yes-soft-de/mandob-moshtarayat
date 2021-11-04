class Rating {
  num? rate;

  Rating({
      this.rate});

  Rating.fromJson(dynamic json) {
    rate = double.parse(json['rate'] ?? '0');
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['rate'] = rate;
    return map;
  }

}