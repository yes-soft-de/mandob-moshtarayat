import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/utils/components/twaslna_captain_field.dart';
import 'package:mandob_moshtarayat_captain/utils/helpers/custom_flushbar.dart';

class InvoiceDialog extends StatefulWidget {
  final TextEditingController _controller;
  final String imagePath;
  final bool isBilledCalculated;
  final Function(bool?) onPressed;

  InvoiceDialog(this._controller, this.imagePath,
      {required this.onPressed, required this.isBilledCalculated});

  @override
  _InvoiceDialogState createState() => _InvoiceDialogState();
}

class _InvoiceDialogState extends State<InvoiceDialog> {
  bool isBilled = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.warnning),
      scrollable: true,
      content: Container(
          child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                tileColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minLeadingWidth: 8,
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: Text(
                  S.current.totalBillCostHint,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(widget.imagePath),
                  height: 130,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 16,
            ),
            CustomFormField(
              controller: widget._controller,
              hintText: S.current.totalBillCost,
              last: true,
              validator: false,
              numbers: true,
              onChanged: (s) {
                if (mounted) {
                  setState(() {});
                }
              },
            ),
            widget.isBilledCalculated
                ? CheckboxListTile(
                    title: Text(S.current.isBilledForCompany),
                    value: isBilled,
                    onChanged: (value) {
                      isBilled = value ?? false;
                      if (mounted) {
                        setState(() {});
                      }
                    })
                : SizedBox(),
          ],
        ),
      )),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [
        TextButton(
            onPressed: widget._controller.text.isNotEmpty
                ? () {
                    if (widget._controller.text.isNotEmpty) {
                      widget.onPressed(
                          widget.isBilledCalculated ? isBilled : null);
                    }
                  }
                : null,
            child: Text(S.current.save)),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.current.cancel)),
      ],
    );
  }
}
