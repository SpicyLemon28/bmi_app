import 'package:flutter/material.dart';
import './Bmi.dart';


class Instruction extends StatefulWidget {
  Instruction({Key key}) : super(key: key);

  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> with SingleTickerProviderStateMixin {

  AnimationController animController;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    
    animController=AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this 
    );

    animation = Tween(begin: 0.0,end: 0.97).animate(animController)
    ..addListener(() {setState(() {});});

    animController.forward();
  }

    @override
    void dispose(){
      super.dispose();
      animController.dispose();
    }

  @override
  Widget build(BuildContext context) {
 
    final background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bmi_background.png"),
            fit: BoxFit.cover,
        ),
      ),
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          ListView(
            children: <Widget>[
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    texts("Instructions:",
                          "BMI Lets You Know Your Body Condition.", 
                          "• Use a converter to convert your desired values",
                          "• To convert kg-lbs (kg * 2.205).",
                          "• To convert cm-m (cm / 100)."
                    ),
                    button("START!", () {Navigator.pushReplacement(context, new MaterialPageRoute(
                      builder: (BuildContext context) => Bmi()));}),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget texts(text, text1, text2, text3, text4) => FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -0.8),end: Offset.zero).animate(animController),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 200.0),),
            Text(text, style: TextStyle(color: Colors.white, fontSize: 25.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            Text(text1, style: TextStyle(color: Colors.white, fontSize: 20.0,fontStyle: FontStyle.italic),),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            Text(text2, style: TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic)),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            Text(text3, style: TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic)),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            Text(text4, style: TextStyle(color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    ),
  );

  Widget button (String label, Function onTap) => FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(begin: Offset(0.0, -0.6),end: Offset.zero).animate(animController),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
        child: Material(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Center(
              child: Text(
                label, style: TextStyle(color: Colors.white, fontSize: 30.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    ),
  );

}

