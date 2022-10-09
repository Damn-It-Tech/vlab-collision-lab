import 'dart:async';

import 'package:flutter/material.dart';

class ActionBox extends StatefulWidget {
  const ActionBox({Key? key}) : super(key: key);

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  Timer? timer;
  int xValue = 0;
  bool moveright = true;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer t) {
      setState(() {
        if (xValue > 750) {
          moveright = false;
        }
        if (xValue < 0) {
          moveright = true;
        }
        if (moveright)
          xValue += 1;
        else
          xValue -= 1;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget getSphere() {
    return Container(
      height: 50,
      width: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
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
          left: xValue.ceilToDouble(),
          top: 0,
          bottom: 0,
          child: getSphere(),
        )
      ],
    );
  }
}
