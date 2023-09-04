import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/base/base_event.dart';

import '../../base/base_bloc.dart';
import '../../data/repo/user_repo.dart';
import '../../event/signin_event.dart';
import '../../event/signup_event.dart';
import 'package:provider/provider.dart';

import '../../shared/validation.dart';

class SignInBloc extends BaseBloc {
  final _phoneStream = StreamController<String>();
  final _passStream = StreamController<String>();
  final UserRepo _userRepo;

  Stream<String?> get phoneStream =>
      _phoneStream.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneStream.sink;
  Stream<String?> get passStream =>
      _passStream.stream.transform(passValidation);
  Sink<String> get passSink => _passStream.sink;

  var phoneValidation = StreamTransformer<String, String?>.fromHandlers(
      handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add("Invalid phone");
  });

  var passValidation =
      StreamTransformer<String, String?>.fromHandlers(handleData: (pass, sink) {
    if (Validation.isPassValid(pass)) {
      sink.add(null);
      return;
    }
    sink.add("Password too short");
  });

  SignInBloc({required UserRepo userRepo}) : _userRepo = userRepo;
  @override
  void dispatchEvent(BaseEvent baseEvent) {
    switch (baseEvent.runtimeType) {
      case SignInEvent:
        handleSignIn(baseEvent);
        break;
      case SignUpEvent:
        handleSignIn(baseEvent);
        break;
    }
  }

  bool checkValidForm(String phone, String pass) {
    if (phone.isEmpty || phone == null) {
      _phoneStream.sink.add("");
      return false;
    }
    if (pass.isEmpty) {
      _passStream.sink.add("");
      return false;
    }
    return true;
  }

  handleSignIn(event) {
    loadingSink.add(true);
    SignInEvent e = event as SignInEvent;
    if (!checkValidForm(e.phone, e.pass)) {
      loadingSink.add(false);
      return;
    }
    _userRepo.SignIn(e.phone, e.pass).then(
      (value) {
        print(value.displayName);
        loadingSink.add(false);
      },
    );
  }

  handleSignUp(event) {}

  @override
  dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneStream.close();
    _passStream.close();
  }
}
