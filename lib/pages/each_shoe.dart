import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/firebase.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:flutter_shoes_ui_practice/widgets/shoes_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class EachShoe extends StatefulWidget {
  const EachShoe({
    Key? key,
  }) : super(key: key);

  @override
  _EachShoeState createState() => _EachShoeState();
}

class _EachShoeState extends State<EachShoe> {
  final db = FirebaseFirestore.instance;

  moveToBrandCollections(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.brandCollectionsRoute);
  }

  moveToShoeDetails(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.shoeDetailsRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseData>(builder: (context, ds, _) {
      return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                              onPressed: () => moveToBrandCollections(context),
                              icon: Icon(Icons.arrow_back_ios)),
                        ),
                        Text(
                          'Runnig Shoes',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.short_text_outlined))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ShoesStaggeredGridView(db: db)),
                    )
                  ],
                ))),
      );
    });
  }
}
