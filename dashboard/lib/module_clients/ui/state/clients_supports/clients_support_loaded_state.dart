import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_chat/chat_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_chat/model/chat_argument.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_need_support.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_needs_support_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/widget/client_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';

class ClientsNeedSupportLoadedState extends States {
  final ClientsNeedsSupportScreenState screenState;
  final String? error;
  final bool empty;
  final List<ClientsNeedSupportModel>? model;

  ClientsNeedSupportLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }

  String? id;
  String? search;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getClients();
        },
        error: error,
      );
    } else if (empty && search == null) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getClients();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getClients(context)));
  }

  List<Widget> getClients(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model ?? <ClientsNeedSupportModel>[]) {
      widgets.add(ClientCard(
        clientId: element.id,
        clientName: element.clientName,
        image: element.image,
        onTap: () {
          Navigator.of(context).pushNamed(ChatRoutes.chatRoute,
              arguments: ChatArgument(
                roomID: element.roomID,
                userType: 'client',
                guest:element.clientID != '-1' ? false : true,
                userID: int.parse(element.clientID != '-1' ? element.clientID : element.id), 
              ));
        },
      ));
    }
    return widgets;
  }
}
