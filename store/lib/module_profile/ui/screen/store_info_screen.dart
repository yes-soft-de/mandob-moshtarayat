import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_profile/model/store_profile_model.dart';
import 'package:mandob_moshtarayat/module_profile/request/create_store_request.dart';
import 'package:mandob_moshtarayat/module_profile/state_manager/store_profile_state_manager.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';



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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      widget.stateManager.getStore(this);
    });
    widget.stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }
  void refresh(){
    if (mounted) {
      setState(() {});
    }
  }
  void updateStore(CreateStoreRequest request){
    widget.stateManager.updateStore(this,request);
  }
  void goToLogin(){
    Navigator.of(context).pushReplacementNamed(AuthorizationRoutes.LOGIN_SCREEN,arguments:1);
    CustomFlushBarHelper.createError(title:S.current.warnning, message:S.current.pleaseLoginToContinue).show(context);
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: CustomMandopAppBar.appBar(
          context, title: model?.storeOwnerName ?? S.current.storeName,
          actions: [
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: InkWell(
//                customBorder: CircleBorder(),
//                onTap: () {
//                  showDialog(
//                      barrierDismissible: false,
//                      context: context,
//                      builder: (context) {
//                        return Container(
//                          width: MediaQuery.of(context).size.width,
//                          height: MediaQuery.of(context).size.height,
//                          child: Scaffold(
//                            appBar: CustomMandopAppBar.appBar(context,
//                                title: S.current.updateStore),
//                            backgroundColor:
//                            Theme.of(context).scaffoldBackgroundColor,
//                            body: UpdateStoreWidget(
//                              request: CreateStoreRequest(
//                                  id: element.categoryId,
//                                  storeOwnerName: element.storeOwnerName,
//                                  hasProducts: element.hasProducts ? 1 : 0,
//                                  privateOrders: element.privateOrders ? 1 : 0,
//                                  image: element.image,
//                                  openingTime:element.openingTime?.toIso8601String(),
//                                  closingTime:element.closingTime?.toIso8601String(),
//                                  status: element.status
//                              ),
//                              updateStore:
//                                  (id,name,image,products, privateOrder,open,close,status) {
//                                Navigator.of(context).pop();
//                                screenState.updateStore(UpdateStoreRequest(
//                                  status: status,
//                                  id: element.id.toString(),
//                                  storeOwnerName: name,
//                                  storeCategoryId: int.parse(element.categoryId),
//                                  image: image,
//                                  hasProducts: products ? 1 : 0,
//                                  privateOrders: privateOrder ? 1 : 0,
//                                  openingTime: open,
//                                  closingTime: close,
//
//                                ));
//                              },
//                            ),
//                          ),
//                        );
//                      });
//                },
//                child: Container(
//                  decoration: BoxDecoration(
//                      color: Theme
//                          .of(context)
//                          .primaryColor,
//                      shape: BoxShape.circle),
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Icon(
//                      Icons.edit,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//              ),
//            ),
          ]
      ),
      body:currentState.getUI(context),
    );
  }

}
