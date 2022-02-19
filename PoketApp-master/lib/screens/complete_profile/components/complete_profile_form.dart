import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? businessname;
  String? companyregistrationnumber;
  String? VATregistrationnumber;
  String? businessaddress;
  String? city;
  String? State;
  int? post_code;
  String? country;
  String? invoiceaddress = "";
  String? city1 = "";
  String? State1 = "";
  int? post_code1 = 0;
  String? country1 = "";
  bool value = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;

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

  Widget buildCheckbox() => ListTile(
        onTap: () {
          setState(() {
            this.value = !value;
          });
        },
        leading: Checkbox(
          value: value,
          onChanged: (value) {
            setState(() {
              this.value = value!;
            });
          },
        ),
        title: Text('Check if Invoice Address is not same as Business Address'),
      );

  Widget buildInvoiceAddress() => ListTile();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBuisinessnameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildVATRegistrationNoFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildBusinessAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStateFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPostCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCountryFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildCheckbox(),
          if (value == true)
            (SizedBox(height: getProportionateScreenHeight(30))),
          if (value == true) (buildInvoiceAddressFormField()),
          if (value == true)
            (SizedBox(height: getProportionateScreenHeight(30))),
          if (value == true) (buildCity1FormField()),
          if (value == true)
            (SizedBox(height: getProportionateScreenHeight(30))),
          if (value == true) (buildState1FormField()),
          if (value == true)
            (SizedBox(height: getProportionateScreenHeight(30))),
          if (value == true) (buildPostCode1FormField()),
          if (value == true)
            (SizedBox(height: getProportionateScreenHeight(30))),
          if (value == true) (buildCountry1FormField()),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                FirebaseFirestore.instance.collection("user").add({
                  "firstName": firstName.toString(),
                  "lastName": lastName.toString(),
                  "phoneNumber": int.parse(phoneNumber.toString()),
                  "address": address.toString(),
                  "businessName": businessname.toString(),
                  "VATregistrationNumber": VATregistrationnumber.toString(),
                  "businessAddress": businessaddress.toString(),
                  "businessCity": city.toString(),
                  "businessPostCode": post_code,
                  "businessState": State.toString(),
                  "businessCountry": country.toString(),
                  "uid": firebaseUser?.uid,
                  //"VATregistrationNumber": int.parse(VATregistrationnumber.toString()),
                  "invoiceAddress": invoiceaddress.toString(),
                  "invoiceCity": city1.toString(),
                  "invoiceState": State1.toString(),
                  "invoicePostCode": post_code1,
                  "invoiceCountry": country1.toString(),
                });
                print(VATregistrationnumber);
                Navigator.pushNamed(context, SignInScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildCountry1FormField() {
    return TextFormField(
      onSaved: (newValue) => country1 = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCountryNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCountryNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Country",
        hintText: "Enter the country",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPostCode1FormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => post_code1 = int.parse(newValue.toString()),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPostCodeNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPostCodeNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Post Code",
        hintText: "Enter the post code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildState1FormField() {
    return TextFormField(
      onSaved: (newValue) => State1 = newValue,
      decoration: InputDecoration(
        labelText: "State",
        hintText: "Enter the state",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildCity1FormField() {
    return TextFormField(
      onSaved: (newValue) => city1 = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCityNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCityNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter the city",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildInvoiceAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => invoiceaddress = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      minLines: 1,
      maxLines: 2, // allow user to enter 2 line in textfield
      keyboardType: TextInputType
          .multiline, // user keyboard will have a button to move cursor to next line

      decoration: InputDecoration(
        labelText: "Invoice Address",
        hintText: "Enter your invoice address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildCountryFormField() {
    return TextFormField(
      onSaved: (newValue) => country = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCountryNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCountryNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Country",
        hintText: "Enter the country",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPostCodeFormField() {
    return TextFormField(
      onSaved: (newValue) => post_code = int.parse(newValue.toString()),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPostCodeNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPostCodeNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Post Code",
        hintText: "Enter the post code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildStateFormField() {
    return TextFormField(
      onSaved: (newValue) => State = newValue,
      decoration: InputDecoration(
        labelText: "State",
        hintText: "Enter the state",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCityNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCityNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter the city",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon:
        //     CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildBusinessAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => businessaddress = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      minLines: 1,
      maxLines: 1, // allow user to enter 2 line in textfield
      keyboardType: TextInputType
          .multiline, // user keyboard will have a button to move cursor to next line

      decoration: InputDecoration(
        labelText: "Business Address",
        hintText: "Enter Business Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildVATRegistrationNoFormField() {
    return TextFormField(
      onSaved: (newValue) => VATregistrationnumber = newValue,
      decoration: InputDecoration(
        labelText: "VAT Registration Number",
        hintText: "Enter VAT registration number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildBuisinessnameFormField() {
    return TextFormField(
      onSaved: (newValue) => businessname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kBnameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kBnameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Business Name",
        hintText: "Enter your Business Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
