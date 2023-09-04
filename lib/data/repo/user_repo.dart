import 'dart:async';

import 'package:dio/dio.dart';

import '../../shared/constant.dart';
import '../../shared/model/user_data.dart';
import '../remote/user_service.dart';
import '../spref/spref.dart';

class UserRepo {
  UserService _userService;

  UserRepo({required UserService userService}) : _userService = userService;
  Future<UserData> SignIn(String phone, String pass) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signIn(phone, pass);
      var userData = UserData.formJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          c.completeError(
              'Error Response Data: ${e.response!.data}  HTTP Error: ${e.response!.statusCode}');
        } else {
          c.completeError('Request Error: ${e.message}');
        }
      } else {
        c.completeError('Error: $e');
      }
    }
    return c.future;
  }

  Future<UserData> SignUp(String displayName, String phone, String pass) async {
    var c = Completer<UserData>();
    try {
      var response = await _userService.signUp(displayName, phone, pass);
      var userData = UserData.formJson(response.data['data']);
      if (userData != null) {
        SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
        c.complete(userData);
      }
    } on Exception catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          c.completeError(
              'Error Response Data: ${e.response!.data}  HTTP Error: ${e.response!.statusCode}');
        } else {
          c.completeError('Request Error: ${e.message}');
        }
      } else {
        c.completeError('Error: $e');
      }
    }
    return c.future;
  }
}
