import 'timezone.dart';

class CreatedAt {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  factory CreatedAt.fromJson(Map<String, dynamic> json) => CreatedAt(
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
