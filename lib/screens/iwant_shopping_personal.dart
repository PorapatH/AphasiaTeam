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
import 'package:intern/screens/iwant_shopping.dart';
import 'package:provider/provider.dart';

class WantShoppingPersonal extends StatefulWidget {
  @override
  _WantShoppingPersonalState createState() => _WantShoppingPersonalState();
}

class _WantShoppingPersonalState extends State<WantShoppingPersonal> {
  List<IwantModel> iwantModels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readIwshoppingPersonal();
  }

  Future<void> readIwshoppingPersonal() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var shoppingpersonal = firestore
        .collection('Iwant')
        .doc('av9GjXDgd6HdvekrXdNQ')
        .collection('Shopping')
        .doc('EcyywQaTakGDAQtwhXCO')
        .collection('Personal')
        .orderBy('Shid');

    await shoppingpersonal.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.docs;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Pernonal = ${snapshot['Shname']}');

        IwantModel iwantModel = IwantModel.fromMap(snapshot.data());
        setState(() {
          iwantModels.add(iwantModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    String picpersonalsp = iwantModels[index].personal_pic;

    if (picpersonalsp != null) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                picpersonalsp != null
                    ? Image.network(picpersonalsp)
                    : Container(),
              ],
            ),
          ));
    } else if (picpersonalsp == null) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              children: [
                Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/aphasiatalk-169dd.appspot.com/o/Iwant%2Fnoimg.png?alt=media&token=f062776f-34b7-44bd-bbea-43cf0bdb9652'),
              ],
            ),
          ));
    }
  }

  Widget showText(int index) {
    String iwsppersonal = iwantModels[index].personal;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      //height: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          Text(
            iwsppersonal ?? '',
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
                MaterialPageRoute(builder: (context) => Wantshopping()),
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
                          builder: (BuildContext context) =>
                              IwshoppingPersonalTts(),
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
class IwshoppingPersonalTts extends StatefulWidget {
  @override
  _IwshoppingPersonalTtsState createState() => _IwshoppingPersonalTtsState();
}

class _IwshoppingPersonalTtsState extends State<IwshoppingPersonalTts> {
  bool isfav = false;
  @override
  Widget build(BuildContext context) {
    final FlutterTts tts = FlutterTts();

    final args = ModalRoute.of(context).settings.arguments as IwantModel;

    String pic = args.personal_pic;

    if (pic != null) {
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
                  MaterialPageRoute(
                      builder: (context) => WantShoppingPersonal()),
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
                        child: Image.network(args.personal_pic,
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
                      Text('ฉันต้องการ\nซื้อ' + args.personal,
                      textAlign: TextAlign.center,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
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
                          tts.speak('ฉันต้องการซื้อ' + args.personal);
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
                          primary:
                              isfav ? Colors.grey : Colors.yellowAccent[700],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isfav
                            ? Text(
                                "นำออกจากรายการโปรด",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                "เพิ่มในรายการโปรด",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                        onPressed: () {
                          setState(
                            () {
                              isfav = !isfav;
                            },
                          );
                          if (isfav == true) {
                            var img = args.personal_pic;
                            var message = 'ฉันต้องการซื้อ' + args.personal;

                            //เตรียมข้อมูล
                            WantSaved favor =
                                WantSaved(image: img, message: message);

                            //เรียก provider
                            var provider = Provider.of<WantFavProvider>(context,
                                listen: false);
                            provider.addFavorite(favor);
                          } else {
                            var deleteImg = args.personal_pic;
                            var delete = 'ฉันต้องการซื้อ' + args.personal;

                            //prepare data
                            WantSaved favor =
                                WantSaved(image: deleteImg, message: delete);

                            var provider = Provider.of<WantFavProvider>(context,
                                listen: false);
                            provider.delete(favor);

                            print("deleted");
                          }
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
    } else if (pic == null) {
      var imagesrc =
          'https://firebasestorage.googleapis.com/v0/b/aphasiatalk-169dd.appspot.com/o/Iwant%2Fnoimg.png?alt=media&token=f062776f-34b7-44bd-bbea-43cf0bdb9652';
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
                  MaterialPageRoute(
                      builder: (context) => WantShoppingPersonal()),
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
                        child: Image.network(imagesrc, width: 300, height: 300),
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
                      Text('ฉันต้องการ\nซื้อ' + args.personal,
                      textAlign: TextAlign.center,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
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
                          tts.speak('ฉันต้องการซื้อ' + args.personal);
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
                          primary:
                              isfav ? Colors.grey : Colors.yellowAccent[700],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isfav
                            ? Text(
                                "นำออกจากรายการโปรด",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                "เพิ่มในรายการโปรด",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                        onPressed: () {
                          setState(
                            () {
                              isfav = !isfav;
                            },
                          );
                          if (isfav == true) {
                            var img = imagesrc;
                            var message = 'ฉันต้องการซื้อ' + args.personal;

                            //เตรียมข้อมูล
                            WantSaved favor =
                                WantSaved(image: img, message: message);

                            //เรียก provider
                            var provider = Provider.of<WantFavProvider>(context,
                                listen: false);
                            provider.addFavorite(favor);
                          } else {
                            var deleteImg = imagesrc;
                            var delete = 'ฉันต้องการซื้อ' + args.personal;

                            //prepare data
                            WantSaved favor =
                                WantSaved(image: deleteImg, message: delete);

                            var provider = Provider.of<WantFavProvider>(context,
                                listen: false);
                            provider.delete(favor);

                            print("deleted");
                          }
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
}
