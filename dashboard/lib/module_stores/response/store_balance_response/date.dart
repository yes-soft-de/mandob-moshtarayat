import 'timezone.dart';

class Date {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        timezone: json['timezone'] == null
            ? null
            : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
        offset: json['offset'] as int?,
        timestamp: json['timestamp'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'timezone': timezone?.toJson(),
        'offset': offset,
        'timestamp': timestamp,
      };
}
