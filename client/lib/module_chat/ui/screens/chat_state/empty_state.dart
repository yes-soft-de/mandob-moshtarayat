import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/custom_field.dart';
import 'package:mandob_moshtarayat/module_auth/presistance/auth_prefs_helper.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_chat/manager/chat/chat_manager.dart';
import 'package:mandob_moshtarayat/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat/module_chat/state_manager/chat_state_manager.dart';
import 'package:mandob_moshtarayat/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/effect/hidder.dart';
import 'package:mandob_moshtarayat/utils/effect/scaling.dart';

final TextEditingController supportName = TextEditingController();

class EmptyChatPage extends StatelessWidget {
  final ChatStateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;
  final bool sendSupport;

  EmptyChatPage(this._chatStateManager, this._uploadService, this._authService,
      this.sendSupport);
  late ChatArgument args;
  @override
  Widget build(BuildContext context) {
    String chatRoomId = '';
    args = ModalRoute.of(context)?.settings.arguments as ChatArgument;
    chatRoomId = args.roomID;
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
          appBar:
              CustomTwaslnaAppBar.appBar(context, title: S.current.chatRoom),
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ScalingWidget(
                            child: Flushbar(
                              padding: const EdgeInsets.all(16.0),
                              borderRadius: BorderRadius.circular(10),
                              icon: const Icon(
                                Icons.message_rounded,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              title: S.current.note,
                              message: S.current.firstSendMessage,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Hider(
                          active: getIt<AuthService>().isLoggedIn == false,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 16, right: 16),
                            child: ScalingWidget(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          S.current.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    CustomFormField(
                                      controller: supportName,
                                      contentPadding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      hintText: S.current.nameHint,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Lottie.asset('assets/animations/empty_state.json'),
                      ],
                    ),
                  ),
                  ChatWriterWidget(
                    onTap: () {},
                    onMessageSend: (msg) {
                      _chatStateManager.sendMessage(
                          chatRoomId, msg, _authService.username,args);
                      if (sendSupport) {
                        if (getIt<AuthService>().isLoggedIn == false) {
                          getIt<AuthPrefsHelper>()
                              .setUsername(supportName.text);
                        }
                        getIt<ChatManager>().needSupport();
                      }
                    },
                    uploadService: _uploadService,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
