import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/base/base_event.dart';

import '../../base/base_bloc.dart';
import '../../data/repo/user_repo.dart';
import '../../event/signup_event.dart';
import 'package:provider/provider.dart';

import '../../shared/validation.dart';

class SignUpBloc extends BaseBloc {
  final _displayNameStream = StreamController<String>();
  final _phoneStream = StreamController<String>();
  final _passStream = StreamController<String>();
  final UserRepo _userRepo;

  Stream<String?> get displayNameStream =>
      _displayNameStream.stream.transform(displayNameValidation);
  Sink<String> get displayNameSink => _displayNameStream.sink;
  Stream<String?> get phoneStream =>
      _phoneStream.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneStream.sink;
  Stream<String?> get passStream =>
      _passStream.stream.transform(passValidation);
  Sink<String> get passSink => _passStream.sink;

  var displayNameValidation = StreamTransformer<String, String?>.fromHandlers(
      handleData: (displayname, sink) {
    if (Validation.isDisplayNameValid(displayname)) {
      sink.add(null);
      return;
    }
    sink.add("Invalid name");
  });
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

  SignUpBloc({required UserRepo userRepo}) : _userRepo = userRepo;
  @override
  void dispatchEvent(BaseEvent baseEvent) {
    switch (baseEvent.runtimeType) {
      case SignUpEvent:
        handleSignUp(baseEvent);
        break;
    }
  }

  bool checkValidForm(String displayName, String phone, String pass) {
    if (displayName.isEmpty) {
      _displayNameStream.sink.add("");
      return false;
    }
    if (phone.isEmpty) {
      _phoneStream.sink.add("");
      return false;
    }
    if (pass.isEmpty) {
      _passStream.sink.add("");
      return false;
    }
    return true;
  }

  handleSignUp(event) {
    SignUpEvent e = event as SignUpEvent;
    if (!checkValidForm(e.displayName, e.phone, e.pass)) {
      return;
    }
    _userRepo.SignUp(e.displayName, e.phone, e.pass)
        .then((value) => {print(value.displayName)});
  }

  @override
  dispose() {
    // TODO: implement dispose
    super.dispose();
    _displayNameStream.close();
    _passStream.close();
    _phoneStream.close();
  }
}
