import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/each_shoe.dart';
import 'package:flutter_shoes_ui_practice/pages/example.dart';
import 'package:flutter_shoes_ui_practice/pages/shoe_details.dart';
import 'package:flutter_shoes_ui_practice/utils/my_routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShoesStaggeredGridView extends StatelessWidget {
  const ShoesStaggeredGridView({
    Key? key,
    required this.db,
  }) : super(key: key);

  final FirebaseFirestore db;

  moveToShoeDetails(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.shoeDetailsRoute);
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getData() async {
    var firestore = FirebaseFirestore.instance;
    final qn = await firestore
        .collection("nike")
        .doc('collections')
        .collection("basketball")
        .get();
    return qn.docs;
  }

  // DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
      future: getData(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              itemCount: snapshot.data!.length,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 20.0,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data![index];
                return GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShoeDetails())),
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Color(0xffF6F6F6)),
                          child: Column(
                            children: [
                              SizedBox(height: 60.0),
                              Image.network(
                                ds['images'][1],
                                width: MediaQuery.of(context).size.width,
                              ),
                              Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/shoes-app-e2319.appspot.com/o/assets%2Fimages%2Fnike%2Fnike-trademark.png?alt=media&token=80d3aac6-1bba-42d9-b336-6604d35df7e3',
                                      height: 60,
                                      width: 40,
                                      color: Color(0xffCBCBCB),
                                    ),
                                  ),
                                  alignment: Alignment.bottomRight),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${ds['price']}',
                              textScaleFactor: 1.5,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            FavoriteButton(valueChanged: () {})
                          ],
                        ),
                      ),
                      Flexible(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            ds['name'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ))
                    ],
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, index.isEven ? 1.9 : 2.0);
              });
        } else if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
