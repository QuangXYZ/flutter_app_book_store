class UserData {
  String displayName;
  String avata;
  String token;

  UserData(
      {required this.displayName, required this.avata, required this.token});
  factory UserData.formJson(Map<String, dynamic> map) {
    return UserData(
        displayName: map['displayName'],
        avata: map['avatar'],
        token: map['token']);
  }
}
