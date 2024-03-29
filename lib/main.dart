import 'package:flutter/material.dart';
import 'package:intern/Home.dart';
import 'package:intern/provider/WantProvider.dart';
import 'package:intern/provider/provider.dart';
import 'package:intern/provider/FeelProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return FavProvider();
        }),
        ChangeNotifierProvider(create: (context){
          return FeelFavProvider();
        }),
        ChangeNotifierProvider(create: (context){
          return WantFavProvider();
        })
      ],
          child: MaterialApp(
            title: 'Aphasia',
        home: Home(),
      ),
    );
  }
}