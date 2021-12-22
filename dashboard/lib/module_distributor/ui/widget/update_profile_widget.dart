import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/ui/state/store_categories/stores_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/stacked_form.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

class UpdateProfile extends StatefulWidget {
  final Function(String, String, String) updateProfile;
  final String? salary;
  final String? bounce;
  final String? status;
  UpdateProfile(
      {required this.updateProfile, this.bounce, this.salary, this.status});

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController _salaryController;
  late TextEditingController _bounceController;
  String status = 'inActive';

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: Form(
          key: _key,
          child: CustomListView.custom(
              padding: EdgeInsets.only(right: 16, left: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.salary,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _salaryController,
                  hintText: S.current.salary,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, bottom: 8, right: 12, top: 16.0),
                  child: Text(
                    S.current.bounce,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                CustomFormField(
                  controller: _bounceController,
                  hintText: S.current.bounce,
                  numbers: true,
                  last: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ListTileSwitch(
                      switchActiveColor: Colors.green,
                      switchInactiveColor: Colors.red,
                      title: Text(S.current.captainStatus),
                      value: status == 'active',
                      onChanged: (v) {
                        if (v) {
                          status = 'active';
                          setState(() {});
                        } else {
                          status = 'inActive';
                          setState(() {});
                        }
                      }),
                ),
                SizedBox(
                  height: 100,
                ),
              ]),
        ),
        label: S.current.save,
        onTap: () {
          if (_salaryController.text.isNotEmpty) {
            widget.updateProfile(_salaryController.text, _bounceController.text,
                status.toString());
          } else {
            CustomFlushBarHelper.createError(
                    title: S.current.warnning,
                    message: S.current.pleaseCompleteTheForm)
                .show(context);
          }
        });
  }

  @override
  void initState() {
    _salaryController = TextEditingController();
    _bounceController = TextEditingController();
    _salaryController.text = widget.salary ?? '';
    _bounceController.text = widget.bounce ?? '';
    status = widget.status ?? 'inActive';
    super.initState();
  }
}
