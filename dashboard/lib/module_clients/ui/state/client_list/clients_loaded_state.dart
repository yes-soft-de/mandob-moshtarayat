import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_captain/captains_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/clients_routes.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/model/client_list_model.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/screen/clients_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_clients/ui/widget/client_card.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/costom_search.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/custom_list_view.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/empty_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/error_screen.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/fixed_container.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class ClientsLoadedState extends States {
  final ClientsScreenState screenState;
  final String? error;
  final bool empty;
  final List<ClientsListModel>? model;

  ClientsLoadedState(this.screenState, this.model,
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
    for (var element in model ?? <ClientsListModel>[]) {
      widgets.add(ClientCard(
        clientId: element.id,
        clientName: element.clientName,
        image: element.image,
        onTap: () {
          Navigator.of(context).pushNamed(ClientsRoutes.CLIENT_PROFILE,
              arguments: int.parse(element.id));
        },
      ));
    }

    if (model != null) {
      widgets.insert(
          0,
          Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18.0, bottom: 16),
            child: CustomDeliverySearch(
              hintText: S.current.clients,
              onChanged: (s) {
                if (s == '' || s.isEmpty) {
                  search = null;
                  screenState.getClients();
                } else {
                  search = s;
                  screenState.getSearchResult(search!);
                }
              },
            ),
          ));
    }

    return widgets;
  }
}
