import 'package:flutter/material.dart';
import './Instruction.dart';

void main () => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Better Me Index",
  //home: Bmi(),
  home: Instruction(),
  theme: ThemeData(
    unselectedWidgetColor: Colors.white70,
    ),
)
);