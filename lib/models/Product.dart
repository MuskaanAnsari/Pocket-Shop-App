import 'package:flutter/foundation.dart';


class Product {
  late String id;
  late String barcodeValue;
  late String productName;
  late String productVariant;
  late double productPrice;
  late String productImage;
  int quantity = 1;

   Product({
    required this.id,
    required this.barcodeValue,
    required this.productName,
    required this.productVariant,
    required this.productPrice,
    required this.productImage,
  });

  factory Product.fromJson(Map<String , dynamic> jsonData) {
    return Product(
      id: jsonData["_id"],
      barcodeValue: jsonData["barcodeValue"],
      productName: jsonData["productName"],
      productVariant: jsonData["productVariant"],
      productPrice: jsonData["productPrice"],
      productImage: jsonData["productImage"],
    );
  }
}

