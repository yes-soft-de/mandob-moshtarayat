import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_chat/manager/chat/chat_manager.dart';
import 'package:mandob_moshtarayat/module_chat/state_manager/chat_state_manager.dart';
import 'package:mandob_moshtarayat/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';
import 'package:mandob_moshtarayat/utils/effect/scaling.dart';

class EmptyChatPage extends StatelessWidget {
  final ChatStateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;
  final bool sendSupport;

  EmptyChatPage(this._chatStateManager, this._uploadService, this._authService,
      this.sendSupport);

  @override
  Widget build(BuildContext context) {
    String chatRoomId = '';
    chatRoomId = ModalRoute.of(context)?.settings.arguments.toString() ?? '';
      if (chatRoomId.substring(0, 3) == '#S#') {
        chatRoomId = chatRoomId.substring(3);
      }
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
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ScalingWidget(
                            child: Flushbar(
                              padding: EdgeInsets.all(16.0),
                              borderRadius: BorderRadius.circular(10),
                              icon: Icon(
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
                          chatRoomId, msg, _authService.username);
                      if (sendSupport) {
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
