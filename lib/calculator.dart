import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/counter_cubit.dart';

class Calculator extends StatelessWidget {
  String strValue;
  String calculate;
  int counter;

  Calculator({required this.strValue, required this.counter, required this.calculate});

  @override
  Widget build(BuildContext context) {
    int value = int.parse(strValue);

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$value", textScaleFactor: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text("${calculate == "multiply" ? "X" : "/"}"),
                ),
                Text("$counter", textScaleFactor: 5,),
              ],
            ),
            Divider(
              thickness: 10,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
            Text("${calculate == "multiply" ? value*counter : value/counter}", textScaleFactor: 5,)
          ],
        ),
      ),
    );
  }
}
