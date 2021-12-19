import 'timezone.dart';

class DeliveryDate {
  Timezone? timezone;
  int? offset;
  int? timestamp;

  DeliveryDate({this.timezone, this.offset, this.timestamp});

  factory DeliveryDate.fromJson(Map<String, dynamic> json) => DeliveryDate(
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
