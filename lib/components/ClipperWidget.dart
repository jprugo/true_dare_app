import 'package:flutter/material.dart';
import 'package:true_dare_app/utilities/DiagonalClipper.dart';
import 'dart:math' as math;

class ClipWidget extends StatelessWidget{

  final  text;
  final Color color;
  final bool isTop;
  final Function onPressed;

  ClipWidget({@required this.text, @required this.color, @required this.isTop, this.onPressed});

  @override
  Widget build(BuildContext context) {
    if(onPressed==null){
      return mainComponent(context);
    }else {
      return  GestureDetector(
          onTap: onPressed,
          child: mainComponent(context)
    );
    }

  }
  
  Widget mainComponent(context){
    return new ClipPath(
      clipper: DiagonalClipper(isTop: this.isTop),
      child: Container(
        color: color,
        padding: EdgeInsets.all(20.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: isTop? MainAxisAlignment.start:MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Transform.rotate(angle: - math.pi / 9, child: Text(text, style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white),)),
              padding: EdgeInsets.all(50.0),
            )
          ],
        ),
      ),
    ); 
  }
}