import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/account_tile.dart';
import 'package:mandob_moshtarayat/module_auth/authorization_routes.dart';
import 'package:mandob_moshtarayat/utils/text_style/text_style.dart';

class AccountUnsignedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 25.0, left: 25, top: 16, bottom: 16),
          child: Container(
            width: double.maxFinite,
            child: Text(
              S.of(context).account,
              style: StyleText.appBarHeaderStyle,
              textAlign: TextAlign.start,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8),
          child: AccountTile(
            text: S.of(context).login,
            icon: Icons.login_rounded,
            onTap: () {
              Navigator.of(context).pushNamed(AuthorizationRoutes.LOGIN_SCREEN);
            },
          ),
        ),
      ],
    );
  }
}
