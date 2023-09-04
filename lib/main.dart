import 'package:flutter/material.dart';
import 'package:flutter_app_book_store/shared/app_color.dart';

import 'module/signin/signin_page.dart';
import 'module/signup/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        primarySwatch: AppColor.yellow,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SigninPage(),
        '/signUp': (context) => SignUpPage(),
      },
    );
  }
}
