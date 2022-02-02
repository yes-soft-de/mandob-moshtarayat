import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:mandob_moshtarayat/global_nav_key.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/module_notifications/service/fire_notification_service/fire_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_localization/service/localization_service/localization_service.dart';
import 'package:mandob_moshtarayat/module_theme/service/theme_service/theme_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/components/fixed_container.dart';

@injectable
class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(S.of(context).privacyPolicy) ),body:
    SingleChildScrollView(
      child: Container(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(S.of(context).policies),
        ),

      ),
    ),);
  }
}
