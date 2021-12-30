import 'payments_to_store.dart';

class Data {
  num? amountOwedToStore;
  num? sumPaymentsToStore;
  num? total;
  List<PaymentsToStore>? paymentsToStore;

  Data({
    this.amountOwedToStore,
    this.sumPaymentsToStore,
    this.total,
    this.paymentsToStore,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        amountOwedToStore: json['amountOwedToStore'] as num?,
        sumPaymentsToStore: json['sumPaymentsToStore'] as num?,
        total: json['total'] as num?,
        paymentsToStore: (json['paymentsToStore'] as List<dynamic>?)
            ?.map((e) => PaymentsToStore.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'amountOwedToStore': amountOwedToStore,
        'sumPaymentsToStore': sumPaymentsToStore,
        'total': total,
        'paymentsToStore': paymentsToStore?.map((e) => e.toJson()).toList(),
      };
}
