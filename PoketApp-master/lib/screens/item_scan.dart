import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
//import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/check_out_screen.dart';

//providers
import '../providers/products_provider.dart';

//widgets
import 'package:shop_app/screens/widgets/products_item.dart';
import 'cart_screen.dart';

class ScanItemScreen extends StatefulWidget {
  static const routeName = "item_scan-screen";

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanItemScreen> {
  void submitValue(String barcodeValue) {
    Provider.of<ProductsProvider>(context, listen: false).fetchProducts(
      barcodeValue.toString(),
    );
  }

 @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("ITEM SCAN",
        style:TextStyle(
          color: Colors.white,
          
        ) 
        ),
        backgroundColor: Color(0xFF0D47A1),
        
               
      ),
      
    body:Container(
        child:Container(
          padding: EdgeInsets.fromLTRB(130, 550, 0, 0),
        child:
               RaisedButton(
                color: Color(0xFF0D47A1),
                splashColor: Colors.red,
                 
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  child: Text(
                    "I'm done",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                    
                  ),
                  ),
                  
                  //color: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
        
    ),
    ),
      
    
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton:
     
     Container( height:800,width:800,
     alignment: Alignment.center,
     child:
      
       Padding(
        padding: const EdgeInsets.symmetric(),
        child: FloatingActionButton(
          elevation: 4,
          onPressed: () async {
            var result = await BarcodeScanner.scan();
            print(result.rawContent.toString());
            submitValue(result.rawContent.toString());
          },
        
          child: Icon(Icons.qr_code_scanner_sharp),
              backgroundColor: Color(0xFF0D47A1),
                splashColor: Colors.red,
        ),
      ),
     ),
    );
  
  }
}
      
     





 