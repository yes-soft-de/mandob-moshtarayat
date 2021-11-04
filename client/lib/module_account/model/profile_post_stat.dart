class ProfilePostState {
  String? error;
  ProfilePostState.error(this.error);
  ProfilePostState.empty();
  bool get hasError => error != null ;
}