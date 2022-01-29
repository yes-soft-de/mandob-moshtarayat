class ChatArgument {
  String roomID;
  String userType;
  bool support;
  int? userID;

  ChatArgument(
      {required this.roomID,
      required this.userType,
      this.support = false,
      this.userID});
}
