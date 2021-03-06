import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mandob_moshtarayat/consts/social_type.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/account_routes.dart';
import 'package:mandob_moshtarayat/module_account/hive/favorite_store_category.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_model.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/account/account_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/account_app_bar.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/account_tile.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/account_unsigned_app_bar.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/social_widget.dart';
import 'package:mandob_moshtarayat/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat/module_orders/orders_routes.dart';
import 'package:mandob_moshtarayat/module_settings/setting_routes.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class AccountLoadedState extends AccountState {
  AccountScreenState screenState;
  bool signIn;
  ProfileModel? profileModel;
  AccountLoadedState(this.screenState,
      {required this.signIn, this.profileModel})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          signIn ? AccountAppBar(profileModel) : AccountUnsignedAppBar(),
          Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25),
            child: Divider(
              color: Theme.of(context).backgroundColor,
              thickness: 2,
            ),
          ),
          signIn
              ? AccountTile(
                  text: S.of(context).personalData,
                  icon: Icons.person,
                  onTap: () {
                    Navigator.of(context).pushNamed(AccountRoutes.PERSONAL_DATA,
                        arguments: profileModel);
                  },
                )
              : Container(),
          AccountTile(
            text: S.of(context).settings,
            icon: Icons.settings,
            onTap: () {
              Navigator.of(context).pushNamed(SettingRoutes.ROUTE_SETTINGS);
            },
          ),
          Hider(
            active: signIn,
            child: AccountTile(
              text: S.of(context).orderLog,
              icon: Icons.history,
              onTap: () {
                Navigator.of(context).pushNamed(OrdersRoutes.ORDER_LOG);
              },
            ),
          ),
          AccountTile(
            text: S.of(context).directSupport,
            icon: Icons.headphones,
            onTap: () {
              if (profileModel?.roomID == null) {
                if (getIt<FavoriteHiveHelper>().getRoomID() == null) {
                  var uuid = const Uuid();
                  getIt<FavoriteHiveHelper>().setRoomID(uuid.v1());
                }
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                    arguments: ChatArgument(
                        roomID: '${getIt<FavoriteHiveHelper>().getRoomID()}',
                        userType: 'admin',
                        support: true));
              } else {
                Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
                    arguments: ChatArgument(
                        roomID: '${profileModel?.roomID}',
                        userType: 'admin',
                        support: true));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0, left: 25),
            child: Divider(
              color: Theme.of(context).backgroundColor,
              thickness: 2,
            ),
          ),
          AccountTile(
            text: S.of(context).termsOfService,
            icon: Icons.sticky_note_2_rounded,
            onTap: () {
              Navigator.of(context).pushNamed(AccountRoutes.TERMS_OF_USE);
            },
          ),
          AccountTile(
            text: S.of(context).privacyPolicy,
            icon: Icons.privacy_tip_rounded,
            onTap: () {
              Navigator.of(context).pushNamed(AccountRoutes.PRIVECY_POLICY);
            },
          ),
          AccountTile(
            text: S.of(context).about,
            icon: Icons.info,
            onTap: () {
              Navigator.of(context).pushNamed(AccountRoutes.ABOUT_SCREEN);
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SocialWidget(
                    image: FontAwesomeIcons.twitter,
                    type: SocialType.twitter,
                    color: Colors.cyan,
                    onTap: () {
                      launch(
                          'https://m.facebook.com/profile.php?id=100073436632320');
                    },
                  ),
                  SocialWidget(
                    image: FontAwesomeIcons.tiktok,
                    type: SocialType.tiktok,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                    onTap: () {
                      launch('https://www.tiktok.com/@mandoob_quick');
                    },
                  ),
                  SocialWidget(
                    image: FontAwesomeIcons.instagram,
                    type: SocialType.instagram,
                    color: Colors.pink,
                    onTap: () {
                      launch('https://www.instagram.com/mandoob_quick');
                    },
                  ),
                  SocialWidget(
                    image: FontAwesomeIcons.facebook,
                    type: SocialType.facebook,
                    color: Colors.blue,
                    onTap: () {
                      launch(
                          'https://m.facebook.com/profile.php?id=100073436632320');
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 75,
          ),
        ],
      ),
    );
  }
}
