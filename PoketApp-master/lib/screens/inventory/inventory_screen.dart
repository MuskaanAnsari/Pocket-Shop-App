import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  static String routeName = "/inventory";
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List jobs = [];
  List original = [];
  TextEditingController txtQuery = new TextEditingController();

  void loadData() async {
    String jsonStr = await rootBundle.loadString('assets/jobs.json');
    var json = jsonDecode(jsonStr);
    jobs = json;
    original = json;
    setState(() {});
  }

  void search(String query) {
    if (query.isEmpty) {
      jobs = original;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    print(query);
    List result = [];
    jobs.forEach((p) {
      var name = p["title"].toString().toLowerCase();
      if (name.contains(query)) {
        result.add(p);
      }
    });

    jobs = result;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 65.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.filter_alt),
            backgroundColor: Colors.lightBlue,
            elevation: 10,
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 15,
        child: Container(
          width: size.width,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {},
                iconSize: 30,
              ),
              Container(
                width: size.width * 0.20,
              ),
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {},
                iconSize: 30,
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 20,
        leading: IconButton(
            padding: EdgeInsets.only(left: 15),
            iconSize: 35,
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.blue.shade900,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.blue.shade900,
                )),
          )
        ],
        title: TextField(
          controller: txtQuery,
          onChanged: search,
          textAlign: TextAlign.center,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            hintText: "Search here",
            hintStyle: TextStyle(fontSize: 15),
          ),
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_listView(jobs)]),
    );
  }
}

Widget _listView(jobs) {
  return Expanded(
    child: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          var person = jobs[index];
          return ListTile(
            leading: CircleAvatar(
                radius: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(person['companyLogo']),
                )),
            title: Text(person['title'],
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            subtitle: Text(person['address'],
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          );
        }),
  );
}
