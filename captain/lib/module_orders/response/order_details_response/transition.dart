class Transition {
  int? ts;
  String? time;
  int? offset;
  bool? isdst;
  String? abbr;

  Transition({this.ts, this.time, this.offset, this.isdst, this.abbr});

  factory Transition.fromJson(Map<String, dynamic> json) => Transition(
        ts: json['ts'] as int?,
        time: json['time'] as String?,
        offset: json['offset'] as int?,
        isdst: json['isdst'] as bool?,
        abbr: json['abbr'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ts': ts,
        'time': time,
        'offset': offset,
        'isdst': isdst,
        'abbr': abbr,
      };
}
