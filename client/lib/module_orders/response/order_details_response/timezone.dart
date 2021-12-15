import 'location.dart';
import 'transition.dart';

class Timezone {
  String? name;
  List<Transition>? transitions;
  Location? location;

  Timezone({this.name, this.transitions, this.location});

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        name: json['name'] as String?,
        transitions: (json['transitions'] as List<dynamic>?)
            ?.map((e) => Transition.fromJson(e as Map<String, dynamic>))
            .toList(),
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'transitions': transitions?.map((e) => e.toJson()).toList(),
        'location': location?.toJson(),
      };
}
