import 'package:flutter/material.dart';

class Bmi extends StatefulWidget {
  _BmiState createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
	int _weightSelected = 0,
      _heightSelected = 0;

  double weightMultiplier = 1.00,
         heightMultiplier = 0.01;

	TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Color stateColor = Colors.white,
        radioColor = Colors.greenAccent;

  String wHintText = "Weight by KG", 
         hHintText = "Height by CM";

  @override
  Widget build(BuildContext context) {

    final background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/bmi_background.png"), fit: BoxFit.cover)
      )
    );

    final logo = Container(child: Image.asset("assets/bmi_logo.png", width: 300, height: 200));

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          ListView(
            children: <Widget>[
              SafeArea(
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(left: 20, top: 40)),
                      logo,
                      Padding(padding: const EdgeInsets.only(top: 40)),
                      textField("Weight", "Enter $wHintText", Icons.accessibility_new, weightController),
                      radioSelection(['KG', 'POUNDS'], _weightSelected, _onWeightSelected),
                      textField("Height", "Enter $hHintText", Icons.line_weight, heightController),
                      radioSelection(['CM', 'METER'], _heightSelected, _onHeightSelected),
                      calculateButton()
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    
  }

  Widget textField(labelText, hintText, iconText, controllerText) => TextField(
    keyboardType: TextInputType.number,
    style: TextStyle(color: stateColor),
		controller: controllerText,
    cursorColor: stateColor,
    decoration: InputDecoration(
      icon: Icon(iconText, color: stateColor,),
      labelText: labelText, hintText: hintText,
      labelStyle: TextStyle(color: stateColor),
      hintStyle: TextStyle(color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(width: 2, color: stateColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide(width: 3, color: stateColor),
      ),
    ),
  );

  Widget radioSelection(lstText, groupValue, onChanged) => Padding(
    padding: const EdgeInsets.only(left: 70.0),
    child: Row(
      children: <Widget>[
        radioOption(0, groupValue, onChanged),
        Text(lstText[0], style: TextStyle(fontSize: 14.0, color: stateColor)),
        radioOption(1, groupValue, onChanged),
        Text(lstText[1], style: TextStyle(fontSize: 14.0, color: stateColor)
        )
      ]
    )
  );

  Widget radioOption(value, groupValue, onChanged) => Radio<int>(
    activeColor: radioColor,
    value: value, groupValue: groupValue, onChanged: onChanged
  );

  Widget calculateButton() => Padding(
    padding: const EdgeInsets.only(top: 20.0,left:30.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          color: Colors.green,
          child: Text("CALCULATE", style: TextStyle(fontSize: 20.0, color: Colors.white)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          onPressed: () => dialog("BMI Ratio:", _generateBMIResult())
        )
      ]
    )
  );

	_onWeightSelected(int value) {
		var lstWeight = [1.00, 0.45];
    var lstHintText = ['Weight by KG', 'Weight by Pounds'];

		setState(() {
      this.weightController.text = "";
      this.wHintText = lstHintText[value];
      this._weightSelected = value;
      this.weightMultiplier = lstWeight[value];
    });
	}

	_onHeightSelected(int value) {
		var lstHeight = [0.01, 1.00];
    var lstHintText = ['Height by CM', 'Height by Meter'];

		setState(() {
      this.heightController.text = "";
      this.hHintText = lstHintText[value];
      this._heightSelected = value;
      this.heightMultiplier = lstHeight[value];
    });
	}

  String _generateBMIResult() {
    double  weight = double.parse(weightController.text);
    double  height = double.parse(heightController.text);

    double weightR = weight * weightMultiplier;
    double heightR = height * heightMultiplier;

    double bmi = weightR / (heightR * heightR);

    int bmiKey = 0;
    if (bmi > 18.49 && bmi < 25.00) bmiKey = 1;
    if (bmi > 25.01 && bmi < 30.00) bmiKey = 2;
    if (bmi > 30.01) bmiKey = 3;

    var lstBMIResult = ['UNDERWEIGHT', 'HEALTHY', 'OVERWEIGHT', 'OBESE'];
    
    String strBMI = bmi.toStringAsFixed(2);
    
    return "$strBMI" + "\n(" + lstBMIResult[bmiKey] + ")";
  }

  dialog(titleDialog, contentDialog) => showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      backgroundColor: Colors.blueGrey[900],
      title: Text(
        titleDialog, textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0,fontStyle: FontStyle.italic, color: stateColor),
      ),
      content: Text(
        contentDialog, textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24.0,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: stateColor),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OKAY', style: TextStyle(color: stateColor),),
          onPressed: () => Navigator.of(context).pop()
        )
      ]
    )
  );
  
}
