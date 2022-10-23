import 'package:flutter/material.dart';
import 'package:vlab1/action_box.dart';
import 'package:vlab1/buttons_column.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_box.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: const ActionBox(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const ButtonsColumn(),
                ],
              ),
              // const AnimationSplineDefault()
            ],
          ),
        ),
      ),
    );
  }
}
