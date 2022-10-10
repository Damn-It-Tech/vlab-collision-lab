import 'package:flutter/material.dart';
import 'package:vlab1/app_config.dart';

class ActionsView with ChangeNotifier {
  late double xOne = 0;
  late double xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;

  late double v1;
  late double v2;
  int _m1 = 3;
  int _m2 = 1;

  final int delT = 1;

  void initValues() {
    // xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;
    v1 = ((_m1 - _m2) / (_m1 + _m2)) * xOne + 2 * (_m2 * xTwo) / (_m1 + _m2);
    v2 = ((_m2 - _m1) / (_m1 + _m2)) * xTwo + 2 * (_m2 * xOne) / (_m1 + _m2);
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

  int get m1 => _m1;
  set m1(int m1) {
    _m1 = m1;
    notifyListeners();
  }

  int get m2 => _m2;
  set m2(int m2) {
    _m2 = m2;
    notifyListeners();
  }

  void updateVelocity() {
    v1 = ((_m1 - _m2) / (_m1 + _m2)) * xOne + 2 * (_m2 * xTwo) / (_m1 + _m2);
    v2 = ((_m2 - _m1) / (_m1 + _m2)) * xTwo + 2 * (_m2 * xOne) / (_m1 + _m2);
  }
}
