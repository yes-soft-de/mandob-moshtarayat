import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat/abstracts/states/empty_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/error_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat/abstracts/states/state.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/request/favorite_categories.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/favorite/favorite_loaded_state.dart';
import 'package:mandob_moshtarayat/module_home/service/home_service.dart';
import 'package:mandob_moshtarayat/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat/module_account/service/account_service.dart';

@injectable
class FavouriteStateManager {
  final AccountService _accountService;
  final HomeService _homeService;

  FavouriteStateManager(this._accountService, this._homeService);
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  void getCategories(FavoritScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _homeService.getStoreCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getCategories(screenState);
        }, title: '', hasAppbar: false, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            title: '',
            hasAppbar: false,
            onPressed: () {}));
      } else {
        _stateSubject
            .add(FavoriteLoadedState(screenState, categories: value.data));
      }
    });
  }

  void updateFavoriteCategories(
      FavoritScreenState screenState, FavoriteCategoriesRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _accountService.updatefavCategories(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.waiting, message: value.error ?? '')
            .show(screenState.context);
      } else {
        Navigator.of(screenState.context).pop();
        CustomFlushBarHelper.createSuccess(
                title: S.current.waiting, message: S.current.saveSuccess)
            .show(screenState.context);
      }
    });
  }
}
