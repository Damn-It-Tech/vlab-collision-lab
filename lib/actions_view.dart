import 'package:flutter/material.dart';
import 'package:vlab1/app_config.dart';

class ActionsView {
  late double xOne;
  late double xTwo;

  late double v1;
  late double v2;

  final int delT = 1;

  late TextEditingController m1;
  late TextEditingController m2;

  double? get massOne => double.tryParse(m1.text);
  double? get massTwo => double.tryParse(m2.text);

  bool isPaused = false;

  void initValues() {
    xOne = 0;
    xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;
    v1 = 1;
    v2 = 1;
    m1 = TextEditingController(text: "0.5");
    m2 = TextEditingController(text: "1");
  }

  void reverseV1() {
    v1 = -v1;
  }

  void reverseV2() {
    v2 = -v2;
  }

  void updateXOne() {
    xOne += v1 * delT;
  }

  void updateXTwo() {
    xTwo += v2 * delT;
  }

  void updateVelocitiesAfterCollision() {
    double u1 = v1;
    double u2 = v2;
    v1 = ((massOne! - massTwo!) / (massOne! + massTwo!)) * u1 + 2 * (massTwo! * u2) / (massOne! + massTwo!);
    v2 = ((massTwo! - massOne!) / (massOne! + massTwo!)) * u2 + 2 * (massOne! * u1) / (massOne! + massTwo!);

    print("vel: u1:$u1, u2:$u2, v1:$v1, v2:$v2");
  }
}
