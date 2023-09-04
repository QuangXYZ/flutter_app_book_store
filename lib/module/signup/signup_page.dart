import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app_book_store/module/signup/signup_bloc.dart';

import '../../base/base_widget.dart';
import '../../data/remote/user_service.dart';
import '../../data/repo/user_repo.dart';

import '../../event/signup_event.dart';
import '../../shared/app_color.dart';
import '../../shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign Up",
        bloc: [],
        di: [
          Provider(
            create: (_) => UserService(),
          ),
          ProxyProvider<UserService, UserRepo>(
              update: (_, userService, __) =>
                  UserRepo(userService: userService)),
        ],
        child: SignUpFormWidget());
  }
}

class SignUpFormWidget extends StatelessWidget {
  final TextEditingController txtDisplayName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPass = TextEditingController();

  SignUpFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SignUpBloc(userRepo: Provider.of<UserRepo>(context)),
      child: Consumer<SignUpBloc>(
        builder: (context, bloc, child) => Container(
            padding: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20),
              ),
              _buildDisplayNameField(bloc),
              _buildPhoneField(bloc),
              _buildPassField(bloc),
              NormalButton(
                onPressed: () {
                  bloc.event.add(SignUpEvent(
                      displayName: txtDisplayName.text,
                      phone: txtPhone.text,
                      pass: txtPass.text));
                },
                title: 'Sign Up',
              ),
              _buildFooter(context),
            ])),
      ),
    );
  }

  Widget _buildDisplayNameField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.displayNameStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
                controller: txtDisplayName,
                onChanged: (text) {
                  bloc.displayNameSink.add(text);
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: Text("Name"),
                  errorText: msg,
                  hintText: "Name",
                  icon: Icon(
                    Icons.verified_user,
                    color: Colors.blue,
                  ),
                ),
                keyboardType: TextInputType.text)),
      ),
    );
  }

  Widget _buildPhoneField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      value: bloc.phoneStream,
      initialData: null,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
                controller: txtPhone,
                onChanged: (text) {
                  bloc.phoneSink.add(text);
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: Text("Phone"),
                  errorText: msg,
                  hintText: "(+84) 0987654321",
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                ),
                keyboardType: TextInputType.phone)),
      ),
    );
  }

  Widget _buildPassField(SignUpBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              controller: txtPass,
              onChanged: (text) {
                bloc.passSink.add(text);
              },
              cursorColor: Colors.black,
              obscureText: true,
              decoration: InputDecoration(
                label: Text("Password"),
                errorText: msg,
                hintText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.blue,
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildFooter(context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Already have an account",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                decoration: TextDecoration.underline),
          )),
    );
  }
}
