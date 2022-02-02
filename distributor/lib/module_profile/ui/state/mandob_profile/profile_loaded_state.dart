import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/ui/screen/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_profile/ui/widget/add_store_widget.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';

class  ProfileLoadedState extends States {
  final ProfileScreenState screenState;
  final  ProfileModel? profile;
  final String? error;
  final bool empty;

   ProfileLoadedState(this.screenState, this.profile,
      {this.error, this.empty = false})
      : super(screenState);
 late LatLng clientAddress;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStore(screenState.model?.id ?? -1);
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStore(screenState.model?.id ?? -1);
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: [
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.30,
        child: CustomNetworkImage(
          imageSource: profile?.image ?? '',
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.30,
        ),
      ),
      CustomListTile(
        title: S.current.name,
        subTitle: profile?.mandobName,
      ),
      CustomListTile(
        title: S.current.phone,
        subTitle: profile?.phone,
      ),      CustomListTile(
        title: S.current.age,
        subTitle: profile?.age.toString(),
      ),
          CustomListTile(
            title: S.current.bankName,
            subTitle: profile?.bankName,
          ), CustomListTile(
            title: S.current.bankAccountNumber,
            subTitle: profile?.bankNumber,
          ),CustomListTile(
            title: S.current.stc,
            subTitle: profile?.stcPay,
          ),

      Container(
        width: double.maxFinite,
        color:profile?.status =='inactive'? Colors.red:Colors.green ,
          padding:
              const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
          child: Center(child: Text(profile?.status =='inactive' ? S.of(context).yourAccountInActive : S.of(context).yourAccountActive)),
        ),
    ]));
  }

  Widget CustomListTile(
      {required String title, String? subTitle, bool? serve}) {
    var context = screenState.context;
    if (serve != null) {
      return Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.symmetric(
                  horizontal: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1),
                )),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Text(title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          Container(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          Expanded(
              child: Container(
            color: serve ? Colors.green : Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16, left: 8, right: 8),
              child: Center(
                child: Text(
                  serve ? S.current.serve : S.current.notServe,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ))
        ],
      );
    }
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          width: 130,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.symmetric(
                horizontal: BorderSide(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 1),
              )),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
        ),
        Container(
          width: 4,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        Expanded(
            child: Container(
          color: Theme.of(context).backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 16, left: 8, right: 8),
            child: Text(
              subTitle ?? '',
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ))
      ],
    );
  }

}
