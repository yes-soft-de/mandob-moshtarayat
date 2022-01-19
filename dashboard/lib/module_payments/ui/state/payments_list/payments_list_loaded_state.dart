import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/model/payments_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_payments/ui/screen/payments_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';

class PaymentsLoadedState extends States {
  final PaymentsListScreenState screenState;
  final String? error;
  final bool empty;
  final List<PaymentsModel>? model;

  PaymentsLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  TextStyle cStyle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle rStyle = TextStyle();
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getPayments();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getPayments();
          });
    }
    return SingleChildScrollView(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTable(
              dividerThickness: 2,
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return Theme.of(context)
                    .primaryColor; // Use default value for other states and odd rows.
              }),
              columns: [
                DataColumn(
                    label: Text(
                  S.current.name,
                  style: cStyle,
                )),
                DataColumn(
                  numeric: true,
                    label: Text(
                  'ID',
                  style: cStyle,
                )),
                DataColumn(
                    label: Text(
                  'TransID',
                  style: cStyle,
                )),
                DataColumn(
                  numeric: true,
                    label: Text(
                  S.current.orderNumber,
                  style: cStyle,
                )),
                DataColumn(
                    numeric: true,
                    label: Text(
                      S.current.cost,
                      style: cStyle,
                    )),
                DataColumn(
                    label: Text(
                  S.current.orderDate,
                  style: cStyle,
                )),
                  DataColumn(
                    label: Text(
                  S.current.payStatus,
                  style: cStyle,
                )),
              ],
              rows: rows(),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> rows() {
    List<DataRow> rowsData = [];
    int index = 0;
    model?.forEach((element) {
      rowsData.add(DataRow(
          color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // Even rows will have a grey color
            if (model?.indexOf(element).isEven == false) {
              return Theme.of(screenState.context).backgroundColor;
            }
            return null; // Use default value for other states and odd rows.
          }),
          cells: [
            DataCell(Text(
              element.clientName,
              style: rStyle,
            )),
            DataCell(Text(
              element.id.toString(),
              style: rStyle,
            )),
            DataCell(Text(
              element.transactionId.toString(),
              style: rStyle,
            )),
            DataCell(Text(
              element.orderNumber.toString(),
              style: rStyle,
            )),
            DataCell(Text(
              element.amount.toString(),
              style: rStyle,
            )),
            DataCell(Text(
              DateFormat.yMEd().format(element.createdAt),
              style: rStyle,
            )),
            DataCell(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:element.payStatus == 'not paid'? Colors.red : Colors.green
                ),
              ),
            )),
          ]));
      index += 1;
    });
    return rowsData;
  }
}
