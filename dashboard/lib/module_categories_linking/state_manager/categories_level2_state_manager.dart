import 'package:injectable/injectable.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/loading_state.dart';
import 'package:mandob_moshtarayat_dashboad/abstracts/states/state.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories/model/subCategoriesModel.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/service/linking_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/screen/level_tow_categories_list_screen.dart';
import 'package:mandob_moshtarayat_dashboad/module_categories_linking/ui/state/categories_level2/categories_level2_loaded_state.dart';
import 'package:mandob_moshtarayat_dashboad/module_localization/service/localization_service/localization_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_dashboad/module_auth/service/auth_service/auth_service.dart';
import 'package:mandob_moshtarayat_dashboad/module_upload/service/image_upload/image_upload_service.dart';

@injectable
class CategoriesLevel2ListStateManager {
  final LinkingService _categoriesService;

  final AuthService _authService;

  final ImageUploadService _uploadService;

  final LocalizationService _localizationService;

  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CategoriesLevel2ListStateManager(this._categoriesService, this._authService,
      this._uploadService, this._localizationService);

  void getCategoriesLevel2(LevelTowCategoriesListScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _categoriesService.getSubcategoriesLevelTow().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            CategoriesLevel2LoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(CategoriesLevel2LoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        SubCategoriesModel cats = value as SubCategoriesModel;
        _stateSubject.add(CategoriesLevel2LoadedState(screenState, cats.data));
      }
    });
  }
}
