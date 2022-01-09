import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/service/linking_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/sub_categories_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/state/sub_categories_list/sub_categories_loaded_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_stores/service/store_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';
import 'package:mandob_moshtarayat_dashboad/utils/helpers/custom_flushbar.dart';

@injectable
class SubCategoriesListStateManager {
  final StoresService _storesService;
  final LinkingService _categoriesService;
  final AuthService _authService;
  final ImageUploadService _uploadService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SubCategoriesListStateManager(this._storesService, this._authService,
      this._uploadService, this._categoriesService);

  void getCategoriesLevelOne(SubCategoriesListScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getSubCategories().then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else if (value.isEmpty) {
        _stateSubject.add(SubCategoriesListLoadedState(screenState, null));
      } else {
        SubCategoriesModel cats = value as SubCategoriesModel;
        _stateSubject.add(SubCategoriesListLoadedState(screenState, cats.data));
      }
    });
  }
}
