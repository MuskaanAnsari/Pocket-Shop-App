import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/payment_success.dart';

import '../size_config.dart';

class CashPay extends StatefulWidget {
  const CashPay({Key? key}) : super(key: key);

  static const routeName = "CashPay";
   @override
  _CashPayState createState() => _CashPayState();
}

class _CashPayState extends State<CashPay> {
  final GlobalKey<FormState> _formKey = GlobalKey();

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
            "Cash Payment",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  heightFactor: 1.7,
                  child: Image(
                    image: AssetImage('assets/images/cash_logo.png'),
                    width: MediaQuery.of(context).size.width * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "CASH PAYMENT DETAILS",
                  // style: Theme.of(context).textTheme.bodyText1,
                  //style: headingStyle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "ADDRESS 1",
                              hintText: " ",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Field is required";
                              return null;
                            }),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "ADDRESS 2",
                            hintText: " ",
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "CITY",
                                    hintText: " ",
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return "Field is required";
                                    return null;
                                  }),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "ZIP CODE",
                                    hintText: " ",
                                  ),
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) return "Field is required";
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "TOTAL\n",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 50,
                          ),
                          child: RaisedButton(
                            child: Text(
                              "CONFIRM PAYMENT",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                              Navigator.of(context).pushNamed(Success.routeName);
                              }
                            },
                            color: Color(0xFF0D47A1),
                            // color: Theme.of(context).accentColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}