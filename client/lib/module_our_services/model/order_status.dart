class OrderStateModel {
  String? _error;

  OrderStateModel.None();

  OrderStateModel.Error(this._error);

  bool get hasError => _error != null;

  String get getError => _error ?? '';
}
