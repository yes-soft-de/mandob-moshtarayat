import 'cost_details.dart';

class CostDetailsResponse {
  CostDetails? costDetails;

  CostDetailsResponse({this.costDetails});

  factory CostDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CostDetailsResponse(
      costDetails: json['costDetails'] == null
          ? null
          : CostDetails.fromJson(json['costDetails'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'costDetails': costDetails?.toJson(),
      };
}
