import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/firebase.dart';
import 'package:flutter_shoes_ui_practice/pages/my_app.dart';
import 'package:flutter_shoes_ui_practice/pages/shoe_details.dart';
import 'package:provider/provider.dart';

main() async {
  //
  WidgetsFlutterBinding
      .ensureInitialized(); // after upgrading flutter this is now necessary
  //
  await Firebase.initializeApp();
  //
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ForText()),
      Provider<FirebaseData>(create: (_) => FirebaseData()),
      ChangeNotifierProvider(create: (context) => ForFirebaseData()),
    ],
    child: const MyApp(),
  ));
  //
}
