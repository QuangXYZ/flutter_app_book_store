import '../base/base_event.dart';

class SignInEvent extends BaseEvent {
  late String phone;
  late String pass;
  SignInEvent({required this.phone, required this.pass});
}
