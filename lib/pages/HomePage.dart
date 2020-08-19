import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:true_dare_app/components/ClipperWidget.dart';
import 'package:true_dare_app/models/Game.dart';
import 'package:true_dare_app/models/User.dart';
import 'package:true_dare_app/pages/ActionPage.dart';

import 'package:file_picker/file_picker.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const TRUE_VALUE = "VERDAD";
  static const DARE_VALUE = "RETO";

  int _round = 0;

  bool _selectedFile = false;
  List<Game> _list;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipWidget(
            text: TRUE_VALUE,
            isTop: true,
            color: Color.fromRGBO(3, 0, 86, 1),
            onPressed: () {
              print(_selectedFile.toString());
              if (_selectedFile) {
                navigate(TRUE_VALUE, _list);
              } else {
                convertJsonToPlay().then((value) {
                  _selectedFile = true;
                  _list = value;
                  navigate(TRUE_VALUE, _list);
                });
              }
            },
          ),
          ClipWidget(
            text: DARE_VALUE,
            isTop: false,
            color: Color.fromRGBO(254, 1, 154, 1),
            onPressed: () {
              if (_selectedFile) {
                navigate(DARE_VALUE, _list);
              } else {
                convertJsonToPlay().then((value) {
                  _selectedFile = true;
                  _list = value;
                  navigate(DARE_VALUE, _list);
                });
              }
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Transform.rotate(
              angle: -math.pi / 9,
              child: Chip(
                label: Text(users[_round].name),
                avatar: Icon(Icons.person),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Game>> convertJsonToPlay() async {
    File file = await FilePicker.getFile();
    var reading = await file.readAsString();
    List<Game> list = List<Game>();


    (json.decode(reading) as List).map((e) {
      if (!(e['description'].toString().isEmpty &&
          e['hotLevel'].toString().isEmpty)) {
        list.add(Game.fromJson(e));
      }
    }).toList();

    return list;
  }


  void navigate(var gameType, List<Game> list) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ActionPage(
        type: gameType,
        round: this._round,
        games: list,
      );
    }));
  }
  @override
  void dispose() {
    super.dispose();
  }
}
