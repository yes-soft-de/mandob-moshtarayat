import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/module_auth/service/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/abstracts/module/yes_module.dart';

import 'chat_routes.dart';
import 'ui/screens/chat_page/chat_page.dart';

@injectable
class ChatModule extends YesModule {
  final ChatPage _chatPage;
  final AuthService _authService;

  ChatModule(this._chatPage, this._authService) {
    YesModule.RoutesMap.addAll(getRoutes());
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {ChatRoutes.chatRoute: (context) => _chatPage};
  }
}
