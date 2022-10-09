import 'dart:async';

import 'package:flutter/material.dart';

class ActionBox extends StatefulWidget {
  const ActionBox({Key? key}) : super(key: key);

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  Timer? timer;

  int xOne = 0;
  int xTwo = 750;

  int v1 = 1;
  int v2 = 1;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer t) {
      setState(() {
        //checking edge case for sphere 1
        if (xOne > 750) {
          v1 = -v1;
        }
        if (xOne < 0) {
          v1 = -v1;
        }
        xOne += v1 * 1;

        //checking edge case for sphere 2
        if (xTwo > 750) {
          v2 = -v2;
        }
        if (xTwo < 0) {
          v2 = -v2;
        }
        xTwo += v2 * 1;

        //checking if collision is happening
        if ((xOne - xTwo).abs() < 51) {
          //use equations and give v1 and v2 new values
          v1 = -v1;
          v2 = -v2;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget getSphere(Color? sphereColor) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(shape: BoxShape.circle, color: sphereColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 400,
          width: 800,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.transparent,
          ),
        ),
        Positioned(
          left: xOne.ceilToDouble(),
          top: 0,
          bottom: 0,
          child: getSphere(Colors.red),
        ),
        Positioned(
          left: xTwo.ceilToDouble(),
          top: 0,
          bottom: 0,
          child: getSphere(Colors.green),
        )
      ],
    );
  }
}
