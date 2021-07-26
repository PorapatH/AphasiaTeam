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
  //const Iwant({Key? key}) : super(key: key);

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
    readIwverb2();
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

  Future<void> readIwverb2() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore
        .collection('Iwant')
        .doc('av9GjXDgd6HdvekrXdNQ')
        .collection('Iwverb2');

    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Iwant = ${snapshot['verb2']}');

        IwantModel iwantModel = IwantModel.fromMap(snapshot.data());
        setState(() {
          iwantModels.add(iwantModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    String picverb1 = iwantModels[index].v1pic;
    String picverb2 = iwantModels[index].v1pic;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: [picverb1 != null ? Image.network(picverb1) : Container()],
      ),
    );
  }

  Widget showText(int index) {
    String iwverb1 = iwantModels[index].verb1;
    String iwverb2 = iwantModels[index].verb2;

    return Container(
      //width: MediaQuery.of(context).size.width * 0.5,
      //height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: [Text(iwverb1 ?? ''), Text(iwverb2 ?? '')],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
      children: [
        //showImage(index),
        showText(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          title: const Text('Aphasia', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red[900],
              child: IconButton(
                icon: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Help()),
                  );
                },
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
        itemCount: iwantModels.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return showListView(index);
        },),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text('เมนูหลัก',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Favorite()),
                    );
                  },
                  child: Text('รายการโปรด',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}