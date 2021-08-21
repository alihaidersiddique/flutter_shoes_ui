import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/utils/commons.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:provider/provider.dart';

class ShoeDetails extends StatefulWidget {
  const ShoeDetails({Key? key}) : super(key: key);

  @override
  _ShoeDetailsState createState() => _ShoeDetailsState();
}

class ForFirebaseData with ChangeNotifier {
  Map<String, dynamic>? doc;
  // yeh is liay ta k object k data ko map mai la ayein....

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> getData() async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await _firestore
            .collection('nike/collections/basketball/')
            .doc('UjVClhYMUTukIETB4dtd')
            .get();
    // yeh jo data aya hai yeh as a object aya hai

    if (documentSnapshot.exists) {
      doc = documentSnapshot.data();
      print('$doc');
      // ub object wala data map ki form mai hai.
      // ub asani sa key dal k value li ja sakti hai :)

    } else {
      print("Data doesn't exist");
    }
    notifyListeners();
    // ChangeNotifierProvider ko call krny k liay
  }
}

class _ShoeDetailsState extends State<ShoeDetails>
    with TickerProviderStateMixin {
  moveToEachShoes(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.brandEachCollectionShoesRoute);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ForFirebaseData>().getData();
      // if the getData method doesn't run, it won't get data from Firebase.
      // we use context.read to call the function, it gets the data.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      body: SafeArea(
          child: Container(
        color: Colors.transparent,
        width: Commons.deviceWidth,
        child: Consumer<ForFirebaseData>(builder: (context, value, child) {
          if (value.doc == null) {
            return Center(child: CircularProgressIndicator());
          } else
            return Column(
              children: [
                Container(
                  color: Color(0xffF6F6F6),
                  width: Commons.deviceWidth,
                  height: 300.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: Image.network(
                          '${value.doc!['images'][0]}',
                          width: 300,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                child: IconButton(
                                    onPressed: () => moveToEachShoes(context),
                                    icon: Icon(Icons.arrow_back_ios)),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.short_text_outlined))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0),
                            topRight: Radius.circular(50.0))),
                    padding: EdgeInsets.all(35.0),
                    width: Commons.deviceWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // name and price row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // name area
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${value.doc!['name']}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    "${value.doc!['collection']}",
                                    style: TextStyle(
                                        color: Color(0xffE5E5E5),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              // price area
                              Text(
                                "\$${value.doc!['price']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22.0),
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          // shoes images
                          Container(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.doc!['images'].length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF6F6F6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: Image.network(
                                        '${value.doc!['images'][index]}',
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                          // size and size guide row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Size',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                              Text(
                                'Size Guide',
                                style: TextStyle(
                                    color: Color(0xffE5E5E5),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 20.0),
                          // size boxes
                          Container(
                            height: 55,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: value.doc!['sizes'].length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      width: 55,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF6F6F6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      child: Center(
                                          child: Text(
                                              '${value.doc!['sizes'][index]}')),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          // description expansion panel
                          ExpansionTile(
                            title: Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.0),
                            ),
                            tilePadding: EdgeInsets.only(left: 0),
                            children: [Text('${value.doc!['description']}')],
                          ),
                          SizedBox(height: 50.0),
                          // Add to Cart Button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromHeight(60),
                                primary: Color(0xff2F313A),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 20.0),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
        }),
      )),
    );
  }
}
