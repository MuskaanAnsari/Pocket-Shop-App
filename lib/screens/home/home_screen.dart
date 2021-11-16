import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme: Theme.of(context)
              .textTheme
              .apply(displayColor: kTextColorLanding),
        ),
        child: Builder(
          builder: (context) {
            return Body();
          },
        ));
  }
}
