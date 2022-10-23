import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vlab1/app_config.dart';

class ActionsView {
  late double xOne;
  late double xTwo;

  late double xOnePrev;
  late double xTwoPrev;

  late double v1;
  late double v2;
  late double rmin;

  late double v1prev;
  late double v2prev;

  final double delT = 1;
  final double k = 2000;

  late TextEditingController m1;
  late TextEditingController m2;

  late TextEditingController q1Controller;
  late TextEditingController q2Controller;

  double? get q1 => double.tryParse(q1Controller.text);
  double? get q2 => double.tryParse(q2Controller.text);

  double? get massOne => double.tryParse(m1.text);
  double? get massTwo => double.tryParse(m2.text);

  List<ChartData>? chartData;

  bool isPaused = false;

  bool turnGraphOn = true;

  void initValues() {
    xOne = 0;
    xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;
    chartData = <ChartData>[];

    xOnePrev = xOne;
    xTwoPrev = xTwo;
    v1 = 3; //figure out (choose atleast 5 values)
    v1prev = v1;
    v2 = -3; //figure out
    v2prev = v2;
    m1 = TextEditingController(text: "5"); //figure out (choose atleast 5 values)
    m2 = TextEditingController(text: "5"); //figure out (choose atleast 5 values)
    q1Controller = TextEditingController(text: "1");
    q2Controller = TextEditingController(text: "1");
  }

  void dispose() {
    chartData!.clear();
  }

  void getChartData(double time) {
    if (chartData!.length > 1000) {
      chartData = <ChartData>[];
    }

    double pe = 2000 / (xTwo - xOne);

    chartData!.add(ChartData(time, pe));
  }

  void calRMinimum() {
    double temp1 = 2 * k * q1! * q2!;
    double temp2 = massOne! * v1 * v1 + massTwo! * v2 * v2;
    double d = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;
    rmin = temp1 * d / (temp1 + d * temp2);

    print("rmin is $rmin");
  }

  // void calculateVelocities() {
  //   try {
  //     double temp = 2 * k * q1! * q2!;
  //     double xtemp1 = (xOnePrev - xOne) / ((xOne - xTwo) * (xOnePrev - xTwo));

  //     double v1square = v1prev * v1prev + temp * xtemp1 / massOne!;
  //     if (v1square < 0) {
  //       v1square = -v1square;
  //       v1 = -sqrt(v1square);
  //       // throw ("v1square cannot be negative wtf");
  //     } else {
  //       if (xOne > xOnePrev) {
  //         v1 = sqrt(v1square);
  //       } else {
  //         v1 = -sqrt(v1square);
  //       }
  //     }

  //     double xtemp2 = (xTwo - xTwoPrev) / ((xTwo - xOne) * (xTwoPrev - xOne));
  //     double v2square = v2prev * v2prev + temp * xtemp2 / massTwo!;

  //     if (v2square < 0) {
  //       // throw ("v2square cannot be negative wtf");
  //       v2square = -v2square;
  //       v2 = sqrt(v2square);
  //     } else {
  //       if (xTwo > xTwoPrev) {
  //         v2 = sqrt(v2square);
  //       } else {
  //         v2 = -sqrt(v2square);
  //       }
  //     }

  //     print("v1: $v1, v2: $v2");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void reverseV1() {
    v1 = -v1;
  }

  void reverseV2() {
    v2 = -v2;
  }

  void updateXOne() {
    xOne += v1 * delT;
  }

  void updateVel() {
    double a1 = -k * q1! * q2! / ((xTwo - xOne) * (xTwo - xOne) * massOne!);
    double a2 = k * q1! * q2! / ((xTwo - xOne) * (xTwo - xOne) * massTwo!);

    v1 += a1 * delT;
    // if ((xOne - xOnePrev).abs() < 1) {
    //   v1 += a1 * delT;
    // }
    // if (xOne > xOnePrev) {
    //   v1 += a1 * delT;
    // } else {
    //   v1 -= a1 * delT;
    // }

    v2 += a2 * delT;

    // if ((xTwo - xTwoPrev).abs() < 1) {
    //   v1 += a1 * delT;
    // }
    // if (xTwo > xTwoPrev) {
    //   v2 -= a2 * delT;
    // } else {
    //   v2 += a2 * delT;
    // }
  }

  void updateXTwo() {
    xTwo += v2 * delT;
  }

  void updatePreviousValues() {
    xOnePrev = xOne;
    xTwoPrev = xTwo;
    v1prev = v1;
    v2prev = v2;
  }

  void updateVelocitiesAfterCollision() {
    double u1 = v1;
    double u2 = v2;
    v1 = ((massOne! - massTwo!) / (massOne! + massTwo!)) * u1 + 2 * (massTwo! * u2) / (massOne! + massTwo!);
    v2 = ((massTwo! - massOne!) / (massOne! + massTwo!)) * u2 + 2 * (massOne! * u1) / (massOne! + massTwo!);
    double temp1 = xOnePrev;
    double temp2 = xTwoPrev;
    xOnePrev = xOne;
    xTwoPrev = xTwo;
    xOne = temp1;
    xTwo = temp2;

    print("vel: u1:$u1, u2:$u2, v1:$v1, v2:$v2");
  }
}

class ChartData {
  ChartData(this.time, this.pe);
  final double time;
  final double pe;
}
