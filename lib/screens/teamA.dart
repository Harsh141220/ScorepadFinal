import 'package:flutter/material.dart';
import 'package:harsh/providers/player_details.dart';
import 'package:harsh/screens/loading.dart';
import 'package:provider/provider.dart';
import 'toss.dart';
import '../providers/contents.dart';
import 'teamB.dart';
import '../providers/inn1.dart';
import '../providers/inn2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamA extends StatefulWidget {
  static const routeName = '/teamA';
  int n = 0;

  @override
  _TeamAState createState() => _TeamAState();
}

class _TeamAState extends State<TeamA> {
  String capA;
  List<String> namesA = [];
  //final _firestore = Firebase.instance;
  var _isLoading = false;
  final _key = GlobalKey<FormState>();
  var cont = TextEditingController();
  void _onsaved() {
    _key.currentState.save();
    cont.clear();
    //FocusScope.of(context).unfocus();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Select the Captain",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "Tap on the Captain's name",
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Content>(context);

    final int num = prov.no_of_players;

    return Scaffold(
        appBar: AppBar(
          title: Text('TEAM ${prov.tA}'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Visibility(
                    visible: widget.n >= prov.no_of_players,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select a Captain!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.n,
                      itemBuilder: (ctx, index) => Dismissible(
                        direction: DismissDirection.endToStart,
                        key: Key(prov.namesA[index]),
                        background: Container(
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (right) {
                          setState(() {
                            widget.n--;
                            prov.namesA.removeAt(index);
                            if (prov.batteam == 'A') {
                              Provider.of<Inn1>(context).bat.removeAt(index);
                              Provider.of<Inn2>(context).bowl.removeAt(index);
                            } else {
                              Provider.of<Inn2>(context).bat.removeAt(index);
                              Provider.of<Inn1>(context).bowl.removeAt(index);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            child: ListTile(
                              onTap: widget.n >= prov.no_of_players
                                  ? () {
                                      //_firestore.collection('Team 1').add({
                                      //'Captain':capA

                                      //});
                                      setState(() {
                                        prov.capA = prov.namesA[index];
                                      });
                                    }
                                  : () {},
                              leading: Text(prov.namesA[index]),
                              //title: Text(index.toString()),
                              trailing: prov.capA == null
                                  ? SizedBox(
                                      width: 2,
                                    )
                                  : prov.capA == prov.namesA[index]
                                      ? Icon(Icons.copyright)
                                      : SizedBox(
                                          width: 2,
                                        ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.n < prov.no_of_players,
                    child: Form(
                      key: _key,
                      child: ListTile(
                        title: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a name.';
                              } else if (prov.namesA.contains(value))
                                return value + ' already exists';
                              return null;
                            },
                            onSaved: (_) {
                              _onsaved;
                            },
                            controller: cont,
                            decoration:
                                InputDecoration(hintText: 'Add Player')),
                        trailing: FlatButton(
                            child: Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              //_firestore.collection('Team 1').add({
                              //'Players Name':namesA
                              //});
                              _key.currentState.validate();

                              if (_key.currentState.validate()) {
                                if (prov.batteam == 'A') {
                                  Provider.of<Inn1>(context).addBatting(
                                      Player(name: cont.value.text, team: 'A'));
                                  Provider.of<Inn2>(context).addBowling(
                                      Player(name: cont.value.text, team: 'A'));
                                } else {
                                  Provider.of<Inn2>(context).addBatting(
                                      Player(name: cont.value.text, team: 'A'));
                                  Provider.of<Inn1>(context).addBowling(
                                      Player(name: cont.value.text, team: 'A'));
                                }

                                prov.addA(cont.value.text);
                                widget.n++;
                                _onsaved();
                              }
                            }),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.n >= prov.no_of_players,
                    child: RaisedButton(
                        color: Colors.blue,
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: prov.capA != null
                            ? () {
                                setState(() {
                                  _isLoading = true;
                                });
                                prov.press = true;
                                prov.addA('');
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.of(context)
                                    .pushReplacementNamed(TeamB.routeName);
                              }
                            : () {
                                showAlertDialog(context);
                              }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ));
  }
}
