import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mandob_moshtarayat_captain/module_about/service/about_service/about_service.dart';
import 'package:mandob_moshtarayat_captain/module_about/ui/states/about/about_state.dart';

@injectable
class AboutScreenStateManager {
  final AboutService _aboutService;

  final stateStack = <AboutState>[];

  final _stateSubject = PublishSubject<AboutState>();

  Stream<AboutState> get stateStream => _stateSubject.stream;

  AboutScreenStateManager(
    this._aboutService,
  );
}
