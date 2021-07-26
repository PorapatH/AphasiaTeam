import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intern/models/iwant_model.dart';
import 'package:intern/Favorite.dart';
import 'package:intern/Help.dart';
import 'package:intern/Home.dart';
import 'package:intern/WantBuy.dart';
import 'package:intern/WantDrink.dart';
import 'package:intern/WantEat.dart';
import 'package:intern/WantGo.dart';
import 'package:intern/WantListen.dart';
import 'package:intern/WantRead.dart';
import 'package:intern/WantTalk.dart';
import 'package:intern/WantWatch.dart';

class Iwant extends StatefulWidget {
  const Iwant({Key key}) : super(key: key);

  @override
  _IwantState createState() => _IwantState();
}

class _IwantState extends State<Iwant> {
  //Field
  List<IwantModel> iwantModels = [];

  //Method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readIwverb1();
  }

  Future<void> readIwverb1() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore
        .collection('Iwant')
        .doc('av9GjXDgd6HdvekrXdNQ')
        .collection('Iwverb1');

    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Iwant = ${snapshot['verb1']}');

        IwantModel iwantModel = IwantModel.fromMap(snapshot.data());
        setState(() {
          iwantModels.add(iwantModel);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: iwantModels.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return Text(iwantModels[index].verb1);
          }),
    );
  }
}