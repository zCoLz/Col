import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Time extends AnimatedWidget
{
  Time({Key? key, required this.animation}) :super(key: key,listenable: animation);
  Animation<int> animation;
  
  @override

  Widget build(BuildContext context)
  {
    Duration clockTimer = Duration(seconds: animation.value);
    var Timetext = 'Thời gian ${clockTimer.inMinutes.remainder(60).toString()}:'
    '${(clockTimer.inSeconds.remainder(60)%60).toString().padLeft(2,'0')}';
    return Text('${Timetext}',style: TextStyle(fontSize: 20,color: Colors.black),);
  } 
}