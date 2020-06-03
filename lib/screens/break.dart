import 'dart:math';

import 'package:flutter/material.dart';
import 'package:harsh/screens/bat_ball.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn2.dart';
import '../providers/inn1.dart';
import 'innings1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Break extends StatefulWidget {
  static const routeName = '/break';
  @override
  _BreakState createState() => _BreakState();
}

class _BreakState extends State<Break> {
  int in1tot ;
  int wickets ;
  int extrarun  ;
  int target ;


 // final _firestore= Firebase.instance;
  @override
  Widget build(BuildContext context) {
    Provider.of<Content>(context).balls = 0;
    Provider.of<Inn2>(context).target = Provider.of<Inn1>(context).runs + 1;
    Provider.of<Inn2>(context).ball_left =
        (Provider.of<Content>(context).overs) * 6;
    for (var i in Provider.of<Inn1>(context).bat) {
      i.strike_rate = i.balls_played > 0 ? i.runs * 100 / i.balls_played : 0;
    }
    for (var i in Provider.of<Inn1>(context).bowl) {
      i.overs = i.balls_thrown / 6;
      i.economy = i.balls_thrown > 0 ? i.runs_given * 6 / i.balls_thrown : 0;
    }
    var indexStrike;
    return Scaffold(
      appBar: AppBar(
        title: Text('Time for a Break!'),
        backgroundColor: Colors.black87,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              (Provider.of<Content>(context).batteam == 'A'
                      ? Provider.of<Content>(context).tB
                      : Provider.of<Content>(context).tA) +
                  ' needs ' +
                  Provider.of<Inn2>(context).target.toString() +
                  ' runs in ' +
                  Provider.of<Content>(context).overs.toStringAsFixed(0) +
                  ' overs',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'BATSMEN',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.orange[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.382,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Name',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.132,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Runs',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.125,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Balls',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '6\'s',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '4\'s',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'S.R',
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: Provider.of<Content>(context).namesA.length,
              itemBuilder: (ctx, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.382,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bat[index].name,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.132,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bat[index].runs.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.125,
                    child: Text(
                      Provider.of<Inn1>(context)
                          .bat[index]
                          .balls_played
                          .toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bat[index].six.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bat[index].bound.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        Provider.of<Inn1>(context)
                            .bat[index]
                            .strike_rate
                            .toStringAsFixed(2),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'BOWLERS',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.blue[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.282,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Name',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.132,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Runs',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Overs',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Wickets',
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Economy',
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: Provider.of<Content>(context).namesA.length,
              itemBuilder: (ctx, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.282,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bowl[index].name,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.132,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context)
                          .bowl[index]
                          .runs_given
                          .toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      Provider.of<Inn1>(context).bowl[index].overs.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      Provider.of<Inn1>(context).bat[index].six.toString(),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        Provider.of<Inn1>(context)
                            .bowl[index]
                            .economy
                            .toStringAsFixed(2),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.redAccent,
          child: Text('Start Innings2'),
          onPressed: () {
           // _firestore.collection('Inninngs 1 Data').add({
             // 'Total Runs': in1tot,
              //'Total Wickets': wickets,
              //'Total Extras':extrarun,
              //'Target': target,


            //});
            Provider.of<Content>(context).start = false;
            Provider.of<Content>(context).avatars = [];
            Navigator.of(context).pushReplacementNamed(BatBall.routeName);
          },
        ),
      ),
    );
  }
}
