import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat/module_chat/state_manager/chat_state_manager.dart';
import 'package:mandob_moshtarayat/module_chat/ui/widget/chat_writer/chat_writer.dart';
import 'package:mandob_moshtarayat/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat/utils/components/custom_app_bar.dart';

class LoadingChatPage extends StatelessWidget {
  final ChatStateManager _chatStateManager;
  final ImageUploadService _uploadService;
  final AuthService _authService;

  LoadingChatPage(
      this._chatStateManager, this._uploadService, this._authService);
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
                        Opacity(
                          opacity: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Flushbar(
                              padding: const EdgeInsets.all(16.0),
                              borderRadius: BorderRadius.circular(10),
                              title: '',
                              message: '',
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
                      // _chatStateManager.sendMessage(
                      //     chatRoomId, msg, _authService.username);
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
