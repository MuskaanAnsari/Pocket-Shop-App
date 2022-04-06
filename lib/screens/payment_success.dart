import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/components/default_button.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/cash_payment.dart';

import '../size_config.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  static const routeName = "success";
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/success.gif'),
              width: MediaQuery.of(context).size.width * 0.4,
            ),
          ),
          Text(
            'CONGRATULATION!!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Transaction completed and recorded',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Container(
              width: double.infinity,
              margin: EdgeInsets.all(25),
              child: DefaultButton(
                press: () {},
                text: "Done",
              )),
        ],
      ),
    );
  }
}
