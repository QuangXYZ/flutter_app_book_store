import '../base/base_event.dart';

class SignUpEvent extends BaseEvent {
  late String displayName;
  String phone;
  String pass;
  SignUpEvent(
      {required this.displayName, required this.phone, required this.pass});
}
