import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/each_shoe.dart';
import 'package:flutter_shoes_ui_practice/pages/main_page.dart';
import 'package:flutter_shoes_ui_practice/pages/shoe_details.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:flutter_shoes_ui_practice/pages/shoes_collections.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: MyRoutes.shoesCollectionRoute,
      routes: {
        MyRoutes.homeRoute: (context) => MainPage(),
        MyRoutes.shoesCollectionRoute: (context) => ShoesCollection(),
        MyRoutes.brandCollectionsRoute: (context) => ShoesCollection(),
        MyRoutes.brandEachCollectionShoesRoute: (context) => EachShoe(),
        MyRoutes.shoeDetailsRoute: (context) => ShoeDetails()
      },
    );
  }
}
