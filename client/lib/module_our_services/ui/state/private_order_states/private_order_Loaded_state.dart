import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_our_services/request/private_order_request.dart';
import 'package:mandob_moshtarayat/module_our_services/request/send_it_request.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/screen/private_order_screen.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_finish_order_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/state/private_order_states/private_order_state.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/custom_field_send_it.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/custom_private_order_app_bar.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/label_text.dart';
import 'package:mandob_moshtarayat/module_our_services/ui/widget/private_order_title_bar.dart';
import 'package:mandob_moshtarayat/utils/components/make_order_button.dart';
import 'package:mandob_moshtarayat/utils/components/progresive_image.dart';
import 'package:mandob_moshtarayat/utils/effect/checked.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:mandob_moshtarayat/utils/models/store.dart';

class PrivateOrderLoadedState extends PrivateOrderState {
  PrivateOrderLoadedState(PrivateOrderScreenState screenState)
      : super(screenState);
  String? payments;
  ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> _privateOrder = GlobalKey<FormState>();
  late String title;
  late String backgroundImage;
  late int storeId;
  late num deliveryCost;

  @override
  Widget getUI(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is StoreModel) {
      title = args.storeOwnerName;
      backgroundImage = args.image;
      storeId = args.id;
      deliveryCost = args.deliveryCost;
    }
    return Stack(
      children: [
        CustomNetworkImage(
          imageSource: backgroundImage,
          height: height,
          width: width,
        ),
        CustomPrivateOrderAppBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              color: Colors.black.withOpacity(0.45),
            ),
            height: height * 0.72,
            width: double.maxFinite,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checked(
                checked: MediaQuery.of(context).viewInsets.bottom != 0,
                checkedWidget: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PrivateOrderTitleBar(
                      title: title,
                      rate: 0,
                      views: 40,
                      deliveryCost: deliveryCost),
                ),
              ),
              Container(
                height: height * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                  color: Theme.of(context).cardColor,
                ),
                child: Form(
                  key: _privateOrder,
                  child: ListView(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        title: LabelText(S.of(context).orderDetails),
                        subtitle: CustomSendItFormField(
                          maxLines: 7,
                          hintText: S.of(context).orderDetailHint,
                          controller: screenState.orderDetailsController,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        title: LabelText(S.of(context).note),
                        subtitle: CustomSendItFormField(
                          maxLines: 5,
                          hintText: S.of(context).note,
                          controller: screenState.noteController,
                          validator: false,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom == 0
                            ? 100
                            : 175,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MakeOrderButton(
            onPressed: () {
              if (_privateOrder.currentState!.validate()) {
                PrivateOrderRequest request = PrivateOrderRequest(
                    note: screenState.noteController.text,
                    detail: screenState.orderDetailsController.text,
                    storeOwnerProfileID: storeId,
                    ownerID: title);
                screenState.request = request;
                screenState.getLocation();
                screenState.refresh();
              } else {
                CustomFlushBarHelper.createError(
                    title: S.of(context).warnning,
                    message: S.of(context).pleaseCompleteTheForm)
                  ..show(context);
              }
            },
            text: S.of(context).checkout,
          ),
        ),
      ],
    );
  }
}
