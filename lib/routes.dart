import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/app_payment.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/cash_payment.dart';
import 'package:shop_app/screens/check_out_screen.dart';
//import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/email_sent_success/email_success_screen.dart';
import 'package:shop_app/screens/inventory/inventory_screen.dart';
import 'package:shop_app/screens/item_scan.dart';
import 'package:shop_app/screens/payment_mode.dart';
import 'package:shop_app/screens/payment_success.dart';
import 'package:shop_app/screens/product_complete_success/product_success_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
//import 'package:shop_app/screens/otp/otp_screen.dart';
import 'package:shop_app/screens/product_creation/product_creation_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  //OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  //DetailsScreen.routeName: (context) => DetailsScreen(),
  //CartScreen.routeName: (context) => CartScreen(),
  //ProfileScreen.routeName: (context) => ProfileScreen(),
   CartScreen.routeName: (context) => CartScreen(),
  CheckOutScreen.routeName: (context) => CheckOutScreen(),
   ScanItemScreen.routeName: (context) =>  ScanItemScreen(),
  ProductCreationScreen.routeName: (context) => ProductCreationScreen(),
  EmailSuccessScreen.routeName: (context) => EmailSuccessScreen(),
  ProductSuccessScreen.routeName: (context) => ProductSuccessScreen(),
  InventoryPage.routeName: (context) => InventoryPage(),
   Success.routeName: (context) =>  Success(),
    Paytm.routeName: (context) =>  Paytm(),
     CashPay.routeName: (context) =>  CashPay(),
      PaymentMode.routeName: (context) =>  PaymentMode(),
  
  
  
};
