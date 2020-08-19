import 'package:flutter/foundation.dart';

class Game{
  int hotLevel;
  String type;
  String description;

  Game.fromJson(Map<String, dynamic> json){

    try{
      this.hotLevel=json['hotLevel'];
    }
    catch(E){
      this.hotLevel=0;
      print(E);
    }

     type = json['type'] as String;
    description = json['description'] as String;

  }


  Game({this.hotLevel, this.description,this.type});
}



