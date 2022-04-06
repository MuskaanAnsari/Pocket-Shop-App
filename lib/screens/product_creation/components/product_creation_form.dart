//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/screens/product_complete_success/product_success_screen.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class ProductCreationForm extends StatefulWidget {
  @override
  _ProductCreationFormState createState() => _ProductCreationFormState();
}

class _ProductCreationFormState extends State<ProductCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  bool circular = false;
  PickedFile? _imageFile;
  File? file;
  final List<String?> errors = [];
  String? productname;
  String? description;
  String? image;
  String? currency1;
  String? costprice;
  String? sellingprice;
  String? supplier;
  String? quantity;
  String? qrcode;
  Currency? currency;
  late String url;
  bool isSwitched = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  set imageFile(PickedFile? imageFile) {}

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
            radius: 100.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/images/prodback.png")
                : FileImage(File(_imageFile!.path)) as ImageProvider
            // ),
            ),
        Positioned(
          bottom: 20.0,
          right: 75.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
              size: 50.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          imageProfile(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildProductnameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDiscriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildCurrencyFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          buildCostpriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSellingpriceFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildSupplierFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildQuantityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Center(
            child: SwitchListTile(
              title: const Text('Generate QR Code'),
              value: isSwitched,
              onChanged: (bool value) {
                setState(() {
                  isSwitched = value;
                });
              },
              secondary: const Icon(Icons.qr_code_scanner),
            ),
          ),
          if (isSwitched == true)
            (QrImage(
              data: productname! + firebaseUser!.uid.toString(),
              size: 200,
            )),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Submit",
            press: () async {
              //if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              uploadProductImage();

              FirebaseFirestore.instance.collection("inventory").add({
                "productName": productname.toString(),
                "description": description.toString(),
                "costPrice": costprice,
                "sellPrice": sellingprice,
                "supplier": supplier.toString(),
                "quantity": quantity,
                "uid": firebaseUser!.uid,
                "product_image_url": url,
              });
              Navigator.pushNamed(context, ProductSuccessScreen.routeName);
              //}
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildProductnameFormField() {
    return TextFormField(
      onChanged: (newValue) => productname = newValue,
      decoration: InputDecoration(
        //   labelText: "Product Name",
        hintText: "Product Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildDiscriptionFormField() {
    return TextFormField(
      onSaved: (newValue) => description = newValue,
      minLines: 1,
      maxLines: 10, // allow user to enter 10 line in textfield
      keyboardType: TextInputType.multiline,

      decoration: InputDecoration(
        // labelText: "Discription",
        hintText: "Description",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  // TextFormField buildCurrencyFormField() {
  //   return TextFormField(
  //     onSaved: (newValue) => currency = newValue as Currency?,
  //     onTap: () {
  //       showCurrencyPicker(
  //         context: context,
  //         showFlag: true,
  //         showCurrencyName: true,
  //         showCurrencyCode: true,
  //         onSelect: (Currency currency) {
  //           print("Select Currency: ${currency.name}");
  //         },
  //         favorite: ["INR"],
  //       );
  //     },
  //     decoration: InputDecoration(
  //       //   labelText: "Currency",
  //       hintText: "Currency",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       // suffixIcon:
  //       //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
  //     ),
  //   );
  // }

  TextFormField buildCostpriceFormField() {
    return TextFormField(
      onSaved: (newValue) => costprice = newValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // labelText: "Cost Price",
        hintText: "Cost Price",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildSellingpriceFormField() {
    return TextFormField(
      onSaved: (newValue) => sellingprice = newValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        //  labelText: "Selling Price",
        hintText: "Selling Price",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildSupplierFormField() {
    return TextFormField(
      onSaved: (newValue) => productname = newValue,
      //keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // labelText: "Supplier",
        hintText: "Supplier",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildQuantityFormField() {
    return TextFormField(
      onSaved: (newValue) => quantity = newValue,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        //  labelText: "Quantity",
        hintText: "Quantity",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future uploadProductImage() async {
    String filename = Path.basename(_imageFile!.path);
    Reference storageReference =
        FirebaseStorage.instance.ref().child("product_images/$filename");
    final UploadTask uploadTask =
        storageReference.putFile(File(_imageFile!.path));
    final TaskSnapshot downloadUrl = (await uploadTask);
    url = await downloadUrl.ref.getDownloadURL();
  }
}
