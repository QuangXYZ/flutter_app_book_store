import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../app_color.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback onPressed;
  String title;

  NormalButton({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 45,
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                splashFactory: InkRipple.splashFactory,
                elevation: 2,
                animationDuration: Duration(milliseconds: 1000),
                foregroundColor: Colors.green[300],
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.blue[900],
                decorationThickness: 1.5,
              ),
            )));
  }
}
