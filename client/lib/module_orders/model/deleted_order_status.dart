class MyOrderState {
  String? error;
  MyOrderState.error(this.error);
  MyOrderState.empty();
  bool get hasError => error != null ;
}