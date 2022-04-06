import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/check_out_screen.dart';
import 'package:shop_app/screens/app_payment.dart';

import 'package:shop_app/screens/cash_payment.dart';

import 'package:shop_app/constants.dart';

import '../size_config.dart';

class PaymentMode extends StatelessWidget {
  static const routeName = "paymentmode";
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PAYMENT MODE",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Color(0xFF0D47A1),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "CHOOSE PAYMENT MODE",
                // style: Theme.of(context).textTheme.bodyText1,
                //style: headingStyle,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),

              //         SizedBox(height: getProportionateScreenHeight(5)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 50,
                ),
                child: DefaultButton(
                  text: "CASH",
                  press: () {
                    Navigator.of(context).pushNamed(CashPay.routeName);
                  },
                ),
              ),
              //  SizedBox(height: getProportionateScreenHeight(5)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 50,
                ),
                child: DefaultButton(
                  text: "PayTm",
                  press: () {
                    Navigator.of(context).pushNamed(Paytm.routeName);
                  },
                ),
              ),
              //SizedBox(height: getProportionateScreenHeight(2)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 50,
                ),
                child: DefaultButton(
                  text: "DEBIT/CREDIT CARD",
                  press: () {
                    Navigator.of(context).pushNamed(CheckOutScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
