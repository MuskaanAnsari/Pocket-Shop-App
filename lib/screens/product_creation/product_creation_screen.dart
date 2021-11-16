import 'package:flutter/material.dart';
import 'components/body.dart';

class ProductCreationScreen extends StatelessWidget {
  static String routeName = "/product_creation";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Creation'),
      ),
      body: Body(),
    );
  }
}
