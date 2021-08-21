import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/models/Product.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  String collectionName = 'nike/collections/basketball/';
  getData() {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error ${snapshot.error}');
        if (snapshot.hasData) {
          print('Documents ${snapshot.data!.docs.length}');
          return buildList(context, snapshot.data!.docs);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildList(BuildContext context,
      List<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(
      BuildContext context, DocumentSnapshot<Map<String, dynamic>> data) {
    final record = Product.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: ListTile(
          title: Text("${record.name}"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}
