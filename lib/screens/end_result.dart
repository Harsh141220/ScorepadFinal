import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harsh/screens/bat_ball.dart';
import 'package:harsh/screens/teamA.dart';
import 'details.dart';
import 'package:harsh/screens/toss.dart';
import 'package:provider/provider.dart';
import 'innings2.dart';
import 'innings1.dart';
import '../providers/player_details.dart';
import '../providers/contents.dart';
import '../providers/inn2.dart';
import '../providers/inn1.dart';
import 'imageview360.dart';

class EndResult extends StatefulWidget {
  static const routeName = '/end';
  @override
  _EndResultstate createState() => _EndResultstate();
}

class _EndResultstate extends State<EndResult> {
  //final _firestore=Firebase.instance;
  int in2tot ;
  int wickets ;
  int extrarun  ;
  

  String winningteam;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FINAL RESULT'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  //height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
                      border: Border.all(width: 0.3)),
                  child: Text(
                    '*   (Runrate)',
                    style: TextStyle(
                        fontFamily: 'NimbusRomNo9L',
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.red[600], border: Border.all(width: 0.3)),
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    max(Provider.of<Inn1>(context).runrate,
                            Provider.of<Inn1>(context).runrate)
                        .toString(),
                    style: TextStyle(
                        fontFamily: 'NimbusRomNo9L',
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
            ],
          ),
        ],
      ),
      bottomNavigationBar: RaisedButton(
        child: Text('Details of game'),
        onPressed: () {
          //_firestore.collection('Innings 2 Data').add({
            //'Total Runs': in2tot,
              //'Total Wickets': wickets,
              //'Total Extras':extrarun,
              


          //});
          Provider.of<Content>(context).start = false;
          Provider.of<Content>(context).avatars = [];
          Navigator.of(context).pushReplacementNamed(Details.routeName);
        },
      ),
    );
  }
}
