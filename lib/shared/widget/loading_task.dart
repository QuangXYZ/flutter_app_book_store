import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../base/base_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingTask extends StatelessWidget {
  final BaseBloc bloc;
  final Widget child;

  LoadingTask({required this.bloc, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(children: <Widget>[
        child,
        Consumer<bool>(
            builder: (context, isLoading, child) => isLoading
                ? Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: Colors.blueAccent, size: 70),
                  )
                : Container()),
      ]),
    );
  }
}
