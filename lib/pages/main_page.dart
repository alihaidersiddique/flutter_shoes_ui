import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:flutter_shoes_ui_practice/pages/shoes.dart';
import 'package:flutter_shoes_ui_practice/widgets/shoes_staggered_grid_view.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final db = FirebaseFirestore.instance;

  TabController? _tabController;

  // read the JSON file from your application
  Future<void> loadJsonData() async {
    // loadString method returns future so
    // we have used await async
    var jsonText = await rootBundle.loadString('assets/files/nike_shoes.json');

    // jsonText is holding Json raw string
    // which we decode in proper string through jsonDecode
    final decodeJson = jsonDecode(jsonText);

    // here we are getting the required data from decoded Json proper string
    var nikeRunningShoes = decodeJson["running"];

    Shoes.runningShoes = List.from(nikeRunningShoes)
        .map<Shoes>((runningShoes) => Shoes.fromMap(runningShoes))
        .toList();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
    _tabController = TabController(length: 5, vsync: this);
  }

  moveToShoesCollection(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.shoesCollectionRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.only(right: 50.0),
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(width: 2, color: Color(0xffF7F7F7))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Center(
                    child: TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          icon: Icon(
                            Icons.search_outlined,
                            size: 40,
                            color: Colors.grey.shade300,
                          ),
                          hintText: 'What are you looking for?',
                          hintStyle: TextStyle(color: Colors.grey.shade500)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 175.0,
                child: banner(),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.black,
                        ]),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              SizedBox(
                height: 40.0,
              ),
              TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  isScrollable: true,
                  tabs: [
                    tabBarContent(name: 'Nike', img: 'nike-logo'),
                    tabBarContent(name: 'Reebok', img: 'reebok-logo'),
                    tabBarContent(name: 'Adidas', img: 'adidas-logo'),
                    tabBarContent(name: 'Puma', img: 'puma-logo'),
                    tabBarContent(name: 'Converse', img: 'converse-logo'),
                  ]),
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selected for you',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              SizedBox(height: 30.0),
              ShoesStaggeredGridView(db: db)
            ],
          ),
        ),
      )),
    );
  }

  Widget tabBarContent({required String? name, required String? img}) {
    return GestureDetector(
      onTap: () => moveToShoesCollection(context),
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: Color(0xffF6F6F6),
              radius: 40.0,
              child: Image.asset(
                'assets/images/$img.png',
                height: 60.0,
                width: 60.0,
                alignment: Alignment.center,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('$name',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }

  Widget banner() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 20,
          top: 50,
          child: Text('Nike',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        Positioned(
          top: 30,
          right: 20,
          child: Text(
            'A HERITAGE\n    OF SPEED',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Positioned(
            right: 75,
            bottom: -140,
            child: Image.asset(
              'assets/images/nike-athlete.png',
              height: 400,
              width: 300,
            ))
      ],
    );
  }
}
