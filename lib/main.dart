import 'package:flutter/material.dart';
import 'package:intern/Home.dart';
import 'package:intern/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context){
          return FavProvider();
        })
      ],
          child: MaterialApp(
            title: 'Aphasia',
        home: Home(),
      ),
    );
  }
}