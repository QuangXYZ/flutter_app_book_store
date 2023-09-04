import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_app_book_store/module/signin/signin_bloc.dart';

import '../../base/base_widget.dart';
import '../../data/remote/user_service.dart';
import '../../data/repo/user_repo.dart';
import '../../event/signin_event.dart';
import '../../shared/app_color.dart';
import '../../shared/widget/loading_task.dart';
import '../../shared/widget/normal_button.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign In",
        bloc: [],
        di: [
          Provider(
            create: (_) => UserService(),
          ),
          ProxyProvider<UserService, UserRepo>(
              update: (_, userService, __) =>
                  UserRepo(userService: userService)),
        ],
        child: SignInFormWidget());
  }
}

class SignInFormWidget extends StatelessWidget {
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtPass = TextEditingController();

  SignInFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => SignInBloc(userRepo: Provider.of<UserRepo>(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) => LoadingTask(
          bloc: bloc,
          child: Container(
              padding: EdgeInsets.all(20),
              child: LoadingTask(
                bloc: bloc,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20),
                      ),
                      _buildPhoneField(bloc),
                      _buildPassField(bloc),
                      NormalButton(
                        onPressed: () {
                          bloc.event.add(SignInEvent(
                              phone: txtPhone.text, pass: txtPass.text));
                        },
                        title: 'Sign In',
                      ),
                      _buildFooter(context),
                    ]),
              )),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc) {
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

  Widget _buildPassField(SignInBloc bloc) {
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
        Navigator.pushNamed(context, '/signUp');
      },
      child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Create an account",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                decoration: TextDecoration.underline),
          )),
    );
  }
}
