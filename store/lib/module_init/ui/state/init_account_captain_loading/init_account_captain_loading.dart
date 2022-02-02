import 'package:mandob_moshtarayat/module_init/ui/screens/init_account_screen/init_account_screen.dart';
import 'package:mandob_moshtarayat/module_init/ui/state/init_account/init_account.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class InitAccountCaptainStateLoading extends InitAccountState {
  final String status;
  InitAccountCaptainStateLoading(
      InitAccountScreenState screenState, this.status)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LinearProgressIndicator(),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor
                ),
                child: Icon(Icons.upload_rounded,size: 75,color: Colors.white,),
              ),
              Container(
                height: 65,
                width: double.maxFinite,
                decoration: 
              BoxDecoration(
                borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                color: Theme.of(context).primaryColor
              ),
                child: Center(
                  child: Text('${status}',style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),),
                ),
              ),
            ]),
      ),
    );
  }
}
