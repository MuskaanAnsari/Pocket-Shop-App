import 'package:flutter/material.dart';

import 'components/body.dart';

class ProductSuccessScreen extends StatelessWidget {
  static String routeName = "/product_complete_success";
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
