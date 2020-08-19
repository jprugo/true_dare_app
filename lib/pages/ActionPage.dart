import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:true_dare_app/components/ClipperWidget.dart';
import 'package:true_dare_app/models/Game.dart';
import 'package:true_dare_app/models/User.dart';


class ActionPage extends StatefulWidget {
  final type;
  final int round;
  final List<Game> games;
  ActionPage({Key key, @required this.type, @required this.round, @required this.games}) : super(key: key);

  @override
  _ActionPageState createState() {
    return _ActionPageState();
  }
}

class _ActionPageState extends State<ActionPage> with TickerProviderStateMixin {
  AnimationController controller;

  CurvedAnimation curve;
  Animation<double> curtainOffset;

  List<Game> list;

  Game gg;
  math.Random random;

  int round;
  static const MAX_P_VALUE=1;//SPECIFIED BY INDEX

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    curve = CurvedAnimation(parent: controller, curve: Curves.elasticIn);

    curtainOffset = Tween(begin: 0.0, end: 500.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    round=widget.round;

    Future.delayed(
        const Duration(milliseconds: 300), () => controller.forward());


    list = widget.games
        .where((element) => element.type.compareTo(widget.type) == 0 )
        .toList();

    random = new math.Random();
    setUp(random);

    super.initState();
  }

  void setUp(random) {
    if (list.length >= 1) {
      gg = list[random.nextInt(list.length)];
      list.remove(gg);
      if(!(round==MAX_P_VALUE)){
        round++;
      }else{
        round=0;
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(254, 1, 154, 1),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(254, 1, 154, 0),
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    height: MediaQuery.of(context).size.height * 3 / 4,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromRGBO(254, 1, 154, 1),
                            child: Text(users[round].name[1]),
                          ),
                          RatingBar(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.whatshot,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              gg.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(3, 0, 86, 1)),
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              'CONTINUAR',
                              style: TextStyle(
                                color: Color.fromRGBO(3, 0, 86, 1),
                              ),
                            ),
                            onPressed: () {
                              if (this.controller.isCompleted) {

                                this.controller.reverse().whenComplete(() {
                                  setUp(random);
                                });
                              } else {
                                this.controller.forward();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: "curtain",
            child: GestureDetector(
              onTap: () {
                this.controller.isCompleted
                    ? this.controller.reverse()
                    : this.controller.forward();
              },
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, -curtainOffset.value),
                    child: ClipWidget(
                      text: 'Va: ',
                      isTop: true,
                      color: Color.fromRGBO(3, 0, 86, 1),
                    ),
                  ),


                  Transform.translate(
                    offset: Offset(0, curtainOffset.value),
                    child: ClipWidget(
                      text: users[round].name,
                      isTop: false,
                      color: Color.fromRGBO(254, 1, 154, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
