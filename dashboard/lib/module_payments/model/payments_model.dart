import 'package:mandob_moshtarayat_dashboad/abstracts/data_model/data_model.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/response/payment_list_response/datum.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/date_converter.dart';

class PaymentsModel extends DataModel {
  late int id;
  late String transactionId;
  late String token;
  late num amount;
  late String payStatus;
  late DateTime createdAt;
  late int orderNumber;
  late String clientName;

  PaymentsModel({
    required this.id,
    required this.transactionId,
    required this.token,
    required this.amount,
    required this.payStatus,
    required this.createdAt,
    required this.orderNumber,
    required this.clientName,
  });

  List<PaymentsModel> _model = [];

  PaymentsModel.withData(List<Datum> data) {
    _model = [];
    data.forEach((element) {
      _model.add(PaymentsModel(
        id: element.id ?? -1,
        transactionId: element.transactionId ?? S.current.unknown,
        token: element.token ?? '',
        amount: element.amount ?? 0,
        payStatus: element.payStatus ?? '',
        clientName: element.clientName ?? S.current.unknown,
        createdAt: DateHelper.convert(element.createdAt?.timestamp),
        orderNumber: element.orderNumber ?? -1,
      ));
    });
  }
  List<PaymentsModel> get data => _model;
}
