import 'package:flutter/material.dart';

import 'components/body.dart';

class EmailSuccessScreen extends StatelessWidget {
  static String routeName = "/email_sent_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Email Sent"),
      ),
      body: Body(),
    );
  }
}
