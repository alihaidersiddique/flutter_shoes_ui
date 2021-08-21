import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/each_shoe.dart';
import 'package:flutter_shoes_ui_practice/pages/firebase.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:provider/provider.dart';

class ShoesCollection extends StatefulWidget {
  const ShoesCollection({Key? key}) : super(key: key);

  @override
  _ShoesCollectionState createState() => _ShoesCollectionState();
}

class _ShoesCollectionState extends State<ShoesCollection> {
  final db = FirebaseFirestore.instance;

  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  // moveToSpecificCollectionShoes(BuildContext context, String name) async {
  //   await Navigator.pushNamed(context, MyRoutes.brandEachCollectionShoesRoute, arguments: name);
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ForText>().getData();
      // if the getData method doesn't run, it won't get data from Firebase.
      // we use context.read to call the function, it gets the data.
    });
    // this is for Consumer<ForText> class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  onPressed: () => moveToHome(context),
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            Consumer<ForText>(builder: (context, value, child) {
              return value.brandTitle == null
                  ? CircularProgressIndicator()
                  : Text(
                      "${value.brandTitle!['brand']}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w500),
                    );
            }),
            SizedBox(height: 30.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      db.collection('nike-collections-list-screen').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EachShoe())),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 170.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Color(0xffF6F6F6)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          left: 20,
                                          top: 50,
                                          child: Text(
                                            ds['collection'],
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Positioned(
                                          right: -40,
                                          top: 0,
                                          child: Image.network(
                                            ds['image'],
                                            height: 150,
                                            width: 300,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.0)
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
