import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  ToggleButton({super.key,this.check});
  bool? check;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}
const double _checkTrue = 1;
const double _checkFalse = -1;
const double width = 50;
const double height = 25;
class _ToggleButtonState extends State<ToggleButton> {
  late double xAlign;
  Color checkselected = Colors.grey;
  bool check = false;
  @override
  void initState() {
    super.initState();
    if(this.widget.check==true){
      xAlign = _checkTrue;
      check = true;
      checkselected = Colors.blue;
    }else{
    xAlign = _checkFalse;
    check =false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
            color: checkselected,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            border: Border.all(width: 1,color: Colors.grey)
          ),
      child: Stack(
        children: [
            AnimatedAlign(alignment: Alignment(xAlign,0), duration: Duration(microseconds: 500),
            child: Container(
                width: width*0.5,
                height: height,
                decoration:  BoxDecoration(
                    color: Colors.white ,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),)),
            ),
            ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = _checkTrue;
                check = true;
                checkselected = Colors.blue;
              });
            },
             child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                  ),
                  ),
                ),
          GestureDetector(
             onTap: () {
              setState(() {
                xAlign = _checkFalse;
                check = false;
                checkselected = Colors.grey;
              });
            },
            child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                  ),
                  ),
                ),
        ],
      ),
    );
  }
}