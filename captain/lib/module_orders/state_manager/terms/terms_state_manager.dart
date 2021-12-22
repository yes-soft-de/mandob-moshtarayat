import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/screens/terms/terms.dart';
import 'package:mandob_moshtarayat_captain/module_orders/ui/state/terms/terms_state.dart';
import 'package:mandob_moshtarayat_captain/module_profile/service/profile/profile.service.dart';

@injectable
class TermsStateManager {
  final ProfileService _profileService;

  TermsStateManager(this._profileService);

  final PublishSubject<TermsListState> _termsStateSubject =
      PublishSubject<TermsListState>();

  Stream<TermsListState> get termsStream => _termsStateSubject.stream;

  void getTerms(TermsScreenState screenState) {
    _termsStateSubject.add(TermsListStateLoading(screenState));
    _profileService.getTerms().then((dynamic value) {
      _termsStateSubject.add(TermsListStateInit(value, screenState));
    });
  }
}
