import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/state_manager/store_profile_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';



@injectable
class StoreInfoScreen extends StatefulWidget {
  final StoreProfileStateManager stateManager;

  StoreInfoScreen(this.stateManager);

  @override
  StoreInfoScreenState createState() => StoreInfoScreenState();
}

class StoreInfoScreenState extends State<StoreInfoScreen> {
  bool flagArgs = true;
  late States currentState;
  StoreProfileModel? model;

  void getStore(int id) {
    widget.stateManager.getStore(this);
  }

  @override
  void initState() {
    currentState = LoadingState(this);
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget.stateManager.getStore(this);
    super.initState();
  }
  void refresh(){
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CustomMandopAppBar.appBar(
          context, title: model?.storeOwnerName ?? S.current.storeName,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  // showModalBottomSheet(
                  //   backgroundColor:Colors.transparent.withOpacity(0.0),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //             top: Radius.circular(10))),
                  //     context: context,
                  //     builder: (context) {
                  //       return Container(
                  //         width: double.maxFinite,
                  //         child: Align(
                  //           alignment: Alignment.bottomCenter,
                  //           child: Container(
                  //             constraints: BoxConstraints(
                  //               maxWidth: 600
                  //             ),
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.vertical(
                  //                     top: Radius.circular(10)),
                  //               color: Theme.of(context).scaffoldBackgroundColor
                  //             ),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: <Widget>[
                  //                   Padding(
                  //                     padding: const EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       S.of(context)
                  //                           .storeManagment,
                  //                       style: TextStyle(fontSize: 16.5,
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.only(
                  //                         left: 25, right: 25),
                  //                     child: Container(
                  //                       constraints: BoxConstraints(
                  //                           maxWidth: 600
                  //                       ),
                  //                       child: Divider(
                  //                         thickness: 2.5,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     width: double.maxFinite,
                  //                     constraints: BoxConstraints(
                  //                       maxWidth: 600
                  //                     ),
                  //                     height: 55,
                  //                     // child: TextButton(
                  //                     //   onPressed: () {
                  //                     //     Navigator.pop(context);
                  //                     //     Navigator.of(context)
                  //                     //         .pushNamed(
                  //                     //         CategoriesRoutes.PRODUCT_CATEGORIES,
                  //                     //         arguments: model?.id);
                  //                     //   },
                  //                     //   child: Text(S
                  //                     //       .of(context)
                  //                     //       .addNewCategory,
                  //                     //       style: TextStyle(
                  //                     //           color: Theme
                  //                     //               .of(context)
                  //                     //               .textTheme
                  //                     //               .bodyText1
                  //                     //               ?.color)),
                  //                     // ),
                  //                   ),
                  //                   Container(
                  //                     width: double.maxFinite,
                  //                     height: 55,
                  //                     constraints: BoxConstraints(
                  //                         maxWidth: 600
                  //                     ),
                  //                     child: TextButton(
                  //                       onPressed: () {
                  //                         Navigator.pop(context);
                  //                         // Navigator.of(context)
                  //                         //     .pushNamed(CategoriesRoutes
                  //                         //     .PRODUCT_STORE_CATEGORIES,
                  //                         //     arguments: model?.id);
                  //                       },
                  //                       child: Text(
                  //                         S.of(context)
                  //                             .addProducts,
                  //                         style: TextStyle(
                  //                             color: Theme
                  //                                 .of(context)
                  //                                 .textTheme
                  //                                 .bodyText1
                  //                                 ?.color),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
      body:currentState.getUI(context),
    );
  }

}
