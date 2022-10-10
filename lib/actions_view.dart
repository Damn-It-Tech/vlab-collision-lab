import 'package:vlab1/app_config.dart';

class ActionsView {
  late double xOne;
  late double xTwo;

  late int v1;
  late int v2;

  final int delT = 1;

  void initValues() {
    xOne = 0;
    xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall;
    v1 = 1;
    v2 = 1;
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
}
