import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vlab1/actions_view.dart';
import 'package:vlab1/app_config.dart';
import 'package:vlab1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActionBox extends StatefulWidget {
  const ActionBox({Key? key}) : super(key: key);

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  Timer? timer;
  late ActionsView _actionsView;

  @override
  void initState() {
    super.initState();
    _actionsView = context.read(actionsViewProvider);
    _actionsView.initValues();
    timer = Timer.periodic(const Duration(milliseconds: 1), (Timer t) {
      if (_actionsView.isPaused) {
      } else {
        setState(() {
          //checking edge case for sphere 1
          if (_actionsView.xOne > AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV1();
          }
          if (_actionsView.xOne < 0) {
            _actionsView.reverseV1();
          }
          _actionsView.updateXOne();

          //checking edge case for sphere 2
          if (_actionsView.xTwo > AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV2();
          }
          if (_actionsView.xTwo < 0) {
            _actionsView.reverseV2();
          }
          _actionsView.updateXTwo();

          //checking if collision is happening
          if ((_actionsView.xOne - _actionsView.xTwo).abs() < AppConfigs.sizeOfBall) {
            //use equations and give v1 and v2 new values
            _actionsView.updateVelocitiesAfterCollision();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget getSphere(Color? sphereColor) {
    return Container(
      height: AppConfigs.sizeOfBall,
      width: AppConfigs.sizeOfBall,
      decoration: BoxDecoration(shape: BoxShape.circle, color: sphereColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: AppConfigs.heightOfActionBox,
          width: AppConfigs.widthOfActionBox,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.transparent,
          ),
        ),
        Positioned(
          left: _actionsView.xOne,
          top: 0,
          bottom: 0,
          child: getSphere(Colors.red),
        ),
        Positioned(
          left: _actionsView.xTwo,
          top: 0,
          bottom: 0,
          child: getSphere(Colors.green),
        )
      ],
    );
  }
}
