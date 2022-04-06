import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/components/default_button.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/payment_success.dart';

import '../size_config.dart';

class Paytm extends StatefulWidget {
  const Paytm({Key? key}) : super(key: key);

  static const routeName = "Paytm";
  @override
  _PaytmState createState() => _PaytmState();
}

class _PaytmState extends State<Paytm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF0D47A1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          title: Text(
            "Paytm",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  'Scan your QR here',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Center(
              heightFactor: 1.5,
              child: Image(
                image: AssetImage('assets/images/qr.png'),
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 50,
                    ),
                    child: DefaultButton(
                      text: "CONFIRM PAYMENT",
                      press: () {
                        Navigator.of(context).pushNamed(Success.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
