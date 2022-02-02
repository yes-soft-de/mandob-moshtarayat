import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_captain/consts/urls.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_profile/request/profile/profile_request.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_captain/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat_captain/utils/components/stacked_form.dart';

class ProfileWidget extends StatefulWidget {
  final Function() updateProfile;
  final ProfileRequest request;

  ProfileWidget({
    required this.updateProfile,
    required this.request,
  });

  @override
  State<StatefulWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Widget customListTile(
      {required String title, String? subTitle, required IconData iconData}) {
    Widget? icon;
    if (title == S.current.myStatus) {
      print(subTitle);
      icon = PhysicalModel(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 5,
          shape: BoxShape.circle,
          child: Icon(
            Icons.circle,
            color: subTitle == 'active' ? Colors.green : Colors.red,
            size: 30,
          ));
      subTitle = subTitle == 'active'
          ? S.current.captainStateActive
          : S.current.captainStateInactive;
    }
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(iconData, color: Colors.white),
          )),
      title: Text(
        title,
      ),
      trailing: icon,
      subtitle: Text(
        subTitle ?? S.current.unknown,
        textDirection: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextDirection.ltr
            : null,
        textAlign: S.current.phoneNumber == title &&
                Localizations.localeOf(context).languageCode == 'ar'
            ? TextAlign.right
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StackedForm(
        child: CustomListView.custom(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.maxFinite,
                height: 175,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 175,
                      height: 175,
                      child: CustomNetworkImage(
                        imageSource: widget.request.image ?? '',
                        width: double.maxFinite,
                        height: double.maxFinite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.request.name ?? S.current.username,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customListTile(
                            title: S.of(context).name,
                            subTitle: widget.request.name,
                            iconData: Icons.person_rounded),
                        customListTile(
                            title: S.of(context).age,
                            subTitle: widget.request.age,
                            iconData: Icons.date_range_rounded),
                        customListTile(
                            title: S.of(context).phoneNumber,
                            subTitle: widget.request.phone,
                            iconData: Icons.phone),
                        customListTile(
                            title: S.of(context).car,
                            subTitle: widget.request.car,
                            iconData: Icons.local_taxi_rounded),
                        customListTile(
                            title: S.of(context).bankName,
                            subTitle: widget.request.bankName,
                            iconData: Icons.monetization_on_rounded),
                        customListTile(
                            title: S.of(context).bankAccountNumber,
                            subTitle: widget.request.bankAccountNumber,
                            iconData: Icons.password_rounded),
                        customListTile(
                            title: S.of(context).stcPayCode,
                            subTitle: widget.request.stcPay,
                            iconData: Icons.credit_card_rounded),
                        customListTile(
                            title: S.of(context).myStatus,
                            subTitle: widget.request.isOnline,
                            iconData: Icons.wifi_rounded),
                      ]),
                ),
              ),
            ),
            Container(
              height: 75,
            )
          ],
        ),
        label: S.current.updateProfile,
        onTap: () {
          widget.updateProfile();
        });
  }
}
