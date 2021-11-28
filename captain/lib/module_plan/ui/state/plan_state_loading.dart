import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandob_moshtarayat_captain/generated/l10n.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/screen/plan_screen.dart';
import 'package:mandob_moshtarayat_captain/module_plan/ui/state/plan_state.dart';
import 'package:mandob_moshtarayat_captain/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat_captain/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_captain/utils/images/images.dart';

class PlanScreenStateLoading extends PlanState {
  PlanScreenStateLoading(PlanScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}

class PlanScreenStateError extends PlanState {
  final List<String> errors;
  final PlanScreenState screenState;
  PlanScreenStateError(this.screenState, this.errors) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    List<String> errs = LinkedHashSet<String>.from(errors).toList();
    if (errs.length > 1) {
      return Scaffold(
        appBar: CustomTwaslnaAppBar.appBar(context,
            title: S.of(context).home, buttonBackground: Colors.red),
        body: ErrorStateWidget(
          onRefresh: () {
            screenState.getAccount();
          },
          errors: errs,
        ),
      );
    }
    return Scaffold(
      appBar: CustomTwaslnaAppBar.appBar(context,
          title: S.of(context).home,
          icon: Icons.sort_rounded,
          buttonBackground: Colors.red),
      body: ErrorStateWidget(
        onRefresh: () {
          screenState.getAccount();
        },
        error: errs.first,
      ),
    );
  }
}

class PlanScreenEmptyState extends PlanState {
  final PlanScreenState screenState;
  PlanScreenEmptyState(this.screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                S.current.homeDataEmpty,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          ),
          SvgPicture.asset(
            SvgAsset.EMPTY_SVG,
            height: MediaQuery.of(context).size.height * 0.45,
          ),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0),
                  onPressed: () async {
                    screenState.getAccount();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).refresh,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))),
        ],
      ),
    );
  }
}
