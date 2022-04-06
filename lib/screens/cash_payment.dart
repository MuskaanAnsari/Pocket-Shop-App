import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/components/default_button.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/payment_success.dart';

import '../size_config.dart';
import 'app_payment.dart';
import 'check_out_screen.dart';

class CashPay extends StatefulWidget {
  const CashPay({Key? key}) : super(key: key);

  static const routeName = "CashPay";
  @override
  _CashPayState createState() => _CashPayState();
}

class _CashPayState extends State<CashPay> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? customerName;
  String? city;
  String? zipCode;

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
            "Add Address & Pay ",
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
                  // heightFactor: 1.7,
                  // child: Image(
                  //   image: AssetImage('assets/images/cash_logo.png'),
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                // Text(
                //   "CASH PAYMENT DETAILS",
                //   // style: Theme.of(context).textTheme.bodyText1,
                //   //style: headingStyle,
                //   style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Name",
                              hintText: "John Doe",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return "Field is required";
                              customerName = value;
                              return null;
                            }),
                        SizedBox(height: 10),
                        SizedBox(height: 10),
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
                                    if (value == null || value.isEmpty)
                                      return "Field is required";
                                    city = value;
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
                                    if (value == null || value.isEmpty)
                                      return "Field is required";
                                    zipCode = value;
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Container(
                          child: Consumer<ProductsProvider>(
                              builder: (context, productsData, _) {
                            return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "Total:                                  \t${productsData.totalPrice}",
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            backgroundColor: Colors.grey.shade200,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]);
                          }),
                        ),
                        SizedBox(height: 35),
                         Text(
                  " Payment Methods",
                  // style: Theme.of(context).textTheme.bodyText1,
                  //style: headingStyle,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 20,
                            ),
                            child: DefaultButton(
                              text: "Cash",
                              press: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  saveTransactionData();
                                  Navigator.of(context)
                                      .pushNamed(Success.routeName);
                                }
                              },
                            )),
          
              // SizedBox(height: getProportionateScreenHeight(5)),
                  SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: DefaultButton(
                  text: "PayTm",
                  press: () {
                     if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  saveTransactionData();
                    Navigator.of(context).pushNamed(Paytm.routeName);
                  }
                  },
                ),
              ),
                  SizedBox(height: 0),
              //SizedBox(height: getProportionateScreenHeight(2)),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: DefaultButton(
                  text: "Debit/Credit Card",
                  press: () { if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  saveTransactionData();
                    Navigator.of(context).pushNamed(CheckOutScreen.routeName);
                  }
                  },
                  
                ),
              ),
          
                
                        // Container(
                        //     width: double.infinity,
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 5,
                        //       vertical: 50,
                        //     ),
                        //     child: DefaultButton(
                        //       text: "Confirm Payment",
                        //       press: () {
                        //         if (_formKey.currentState!.validate()) {
                        //           _formKey.currentState!.save();
                        //           saveTransactionData();
                        //           Navigator.of(context)
                        //               .pushNamed(Success.routeName);
                        //         }
                        //       },
                        //     )),
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

  void saveTransactionData() {
    FirebaseFirestore.instance.collection("transaction").add({
      "customerName": customerName.toString(),
      "city": city.toString(),
      "zipCode": zipCode.toString(),
    });
  }
}
