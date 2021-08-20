import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bandnameapp/Models/band.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 10),
    Band(id: '2', name: 'Bon jovi', votes: 3),
    Band(id: '3', name: 'AC DC', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Center(
          child: Text(
            'Band Names',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, int i) => bandListTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 2,
        onPressed: () {
          addNewBand();
        },
      ),
    );
  }

  Widget bandListTile(Band banda) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: Key(banda.id),
      onDismissed: (DismissDirection direccion) {
        print('id ${banda.id}');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Eliminar banda',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.name.substring(0, 2)),
          backgroundColor: Colors.lightBlueAccent,
        ),
        title: Text('${banda.name}'),
        trailing: Text(
          '${banda.votes}',
          style: TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(banda.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Band'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    addBandList(textController.text);
                  },
                  child: Text('Add'),
                  textColor: Colors.black,
                  elevation: 5,
                )
              ],
            );
          });
    }
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('New band name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text('add'),
                  isDefaultAction: true,
                  onPressed: () => addBandList(textController.text)),
              CupertinoDialogAction(
                child: Text('Dismiss'),
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void addBandList(String nameBand) {
    print(nameBand);
    if (nameBand.length > 1) {
      // We can add a new band
      this
          .bands
          .add(Band(id: DateTime.now().toString(), name: nameBand, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
