import 'package:flutter/material.dart';
import 'package:harsh/screens/innings1.dart';
import 'package:provider/provider.dart';
import '../providers/contents.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'dart:convert';
import 'innings2.dart';

class Details extends StatefulWidget {
  static const routeName = '/details';
  @override
  _DetailsState createState() => _DetailsState();
  var teamlistA;
  var teamlistB;
}

class _DetailsState extends State<Details> {
  int innings = 1;

  @override
  Widget build(BuildContext context) {
    Provider.of<Inn2>(context).target = Provider.of<Inn1>(context).runs + 1;
    Provider.of<Inn2>(context).ball_left =
        (Provider.of<Content>(context).overs) * 6;
    for (var i in Provider.of<Inn2>(context).bat) {
      i.strike_rate = i.balls_played > 0 ? i.runs * 100 / i.balls_played : 0;
    }
    for (var i in Provider.of<Inn2>(context).bowl) {
      i.overs = i.balls_thrown / 6;
      i.economy = i.balls_thrown > 0 ? i.runs_given * 6 / i.balls_thrown : 0;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('ScoreCard- Innings$innings'),
      ),
      body: innings == 2
          ? ListView(
              children: <Widget>[
                Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'BATSMEN',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
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
                            Provider.of<Inn2>(context).bat[index].name,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.132,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            Provider.of<Inn2>(context)
                                .bat[index]
                                .runs
                                .toString(),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.125,
                          child: Text(
                            Provider.of<Inn2>(context)
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
                            Provider.of<Inn2>(context)
                                .bat[index]
                                .six
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
                            Provider.of<Inn2>(context)
                                .bat[index]
                                .bound
                                .toString(),
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
                              Provider.of<Inn2>(context)
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
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
                            Provider.of<Inn1>(context)
                                .bowl[index]
                                .overs
                                .toString(),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            Provider.of<Inn1>(context)
                                .bat[index]
                                .six
                                .toString(),
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
            )
          : ListView(
              children: <Widget>[
                Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'BATSMEN',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
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
                            Provider.of<Inn1>(context)
                                .bat[index]
                                .runs
                                .toString(),
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
                            Provider.of<Inn1>(context)
                                .bat[index]
                                .six
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
                            Provider.of<Inn1>(context)
                                .bat[index]
                                .bound
                                .toString(),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
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
                            Provider.of<Inn1>(context)
                                .bowl[index]
                                .overs
                                .toString(),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            Provider.of<Inn1>(context)
                                .bat[index]
                                .six
                                .toString(),
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
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
              title: Text('Innings1'), icon: Icon(Icons.looks_one)),
          BottomNavigationBarItem(
              title: Text('Innings2'), icon: Icon(Icons.looks_two))
        ],
        onTap: (index) {
          setState(() {
            innings = index + 1;
          });
        },
        currentIndex: innings != null ? innings - 1 : 0,
      ),
    );
  }
}
