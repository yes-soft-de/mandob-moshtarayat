import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mandob_moshtarayat/module_about/ui/screen/about_screen/about_screen.dart';
import 'package:mandob_moshtarayat/module_about/ui/states/about/about_state.dart';

class AboutStateLoading extends AboutState {
  AboutStateLoading(AboutScreenState screenState) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
