import 'package:flutter/material.dart';
import 'package:intern/FavMy.dart';
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

/*class Home extends StatefulWidget {
  Home({key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context){
    return FavMy();
  }
}*/