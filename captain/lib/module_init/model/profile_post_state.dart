import 'package:mandob_moshtarayat_captain/generated/l10n.dart';

class ProfilePostState {
  String? _error;
  ProfilePostState.error(this._error);
  ProfilePostState.empty();
  bool get hasError => _error != null;
  String get error => _error ?? S.current.errorHappened;
}
