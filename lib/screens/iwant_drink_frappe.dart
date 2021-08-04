import 'dart:ui';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intern/Favorite.dart';
import 'package:intern/Help.dart';
import 'package:intern/Home.dart';
import 'package:intern/models/WantSaved.dart';
import 'package:intern/models/iwant_model.dart';
import 'package:intern/provider/WantProvider.dart';
import 'package:intern/screens/iwant.dart';
import 'package:intern/screens/iwant_drink.dart';
import 'package:provider/provider.dart';

class WantDrinkFrappe extends StatefulWidget {
  @override
  _WantDrinkFrappeState createState() => _WantDrinkFrappeState();
}

class _WantDrinkFrappeState extends State<WantDrinkFrappe> {

  List<IwantModel> iwantModels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readIwFrappeDrink();
  }

  Future<void> readIwFrappeDrink() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var iwantfrappeDrink = firestore
        .collection('Iwant')
        .doc('av9GjXDgd6HdvekrXdNQ')
        .collection('Drinks')
        .doc('ryJuwG0GIs1sXZ5rQMTy')
        .collection('Frappe')
        .orderBy('Frid');

    await iwantfrappeDrink.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        //print('snapshot = $snapshot');
        //print('Iwant = ${snapshot['']}');

        IwantModel iwantModel = IwantModel.fromMap(snapshot.data());
        setState(() {
          iwantModels.add(iwantModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    String picfrappe = iwantModels[index].frappe_pic;

    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.4,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Row(
        children: [
          picfrappe!= null ? Image.network(picfrappe) : Container(),
        ],
      ),)
    );
  }

  Widget showText(int index) {
    String iwdfrappe = iwantModels[index].frappe_drinks;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      //height: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Text(
            iwdfrappe?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
      children: [
        showImage(index),
        Expanded(
          child: showText(index),
        )
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
                MaterialPageRoute(builder: (context) => WantDrink()),
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
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
              child: Card(
                child: ListTile(
                    tileColor: Colors.teal[900],
                    title: showListView(index),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => IwantTts(),
                          settings:
                              RouteSettings(arguments: iwantModels[index]),
                        ),
                      );
                    }),
              ),
            );
          },
        ),
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

///// --------*****--------คั่นโค้ดหน้าย่อย--------*****-------- /////
///
///
///
class IwantTts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FlutterTts tts = FlutterTts();

    final args =
        ModalRoute.of(context).settings.arguments as IwantModel;

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
                MaterialPageRoute(builder: (context) => WantDrinkFrappe()),
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
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(args.frappe_pic,
                          width: 300, height: 300),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('ฉันต้องการดื่ม' + args.frappe_drinks,
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[900],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'อ่าน',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        tts.speak('ฉันต้องการดื่ม' + args.frappe_drinks);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellowAccent[700],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        textStyle: TextStyle(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'เพิ่มในรายการโปรด',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () {
                        var img = args.frappe_pic;
                        var message = 'ฉันต้องการดื่ม' + args.frappe_drinks;

                        //เตรียมข้อมูล
                        WantSaved favor = WantSaved(image: img, message: message);

                        //เรียก provider
                        var provider = Provider.of<WantFavProvider>(context,listen: false);
                        provider.addFavorite(favor);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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