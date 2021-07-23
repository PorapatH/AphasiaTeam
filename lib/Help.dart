import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';
import "package:flutter_sms/flutter_sms.dart";
import 'package:intern/Favorite.dart';
import 'package:intern/Home.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  // String message = "SOS!";
  // List<String> recipents = [""]; //emergency call or hospital phone number
  int _counter = 0;

  void _sos() {
    if (mounted) {
      setState(() async {
        _counter += 1;
        print(_counter);
        //เพิ่มฟังก์ชั่นสำหรับ เสียงขอความช่วยเหลือ
      });
    }
  }

  // void _sendSMS(String message, List<String> recipents) async {
  //   String _result = await sendSMS(message: message, recipients: recipents)
  //       .catchError((onError) {
  //     print(onError);
  //   });
  //   print(_result);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          title: const Text('Aphasia',
              style: TextStyle(
                  color: Colors.black
              )
          ),
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
                    Image.asset('assets/sos.png',width:200,height:200),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    HoldDetector(
                      onHold: _sos,
                      holdTimeout: Duration(milliseconds: 200),
                      enableHapticFeedback: true,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('ขอความช่วยเหลือ', style: TextStyle(fontSize: 20,),),
                        onPressed: _sos,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/hospital.png',width:200,height:200),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[900],
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          textStyle: TextStyle(fontSize: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('ติดต่อโรงพยาบาล', style: TextStyle(fontSize: 20,),),
                        onPressed: (){}//_sendSMS,
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
                  child: Text('เมนูหลัก', style: TextStyle(color: Colors.black, fontSize: 20)),
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
                  child: Text('รายการโปรด', style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}