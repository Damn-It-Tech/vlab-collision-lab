import 'package:vlab1/app_config.dart';

class ActionsView {
  late double xOne;
  late double xTwo;

  late double xOnePrev;
  late double xTwoPrev;

  late double v1;
  late double v2;
  late double rmin;

  // late double v1prev;
  // late double v2prev;

  final double delT = 1;
  final double k = 2000;

  late double q1;
  late double q2;

  // List<ChartData>? chartPEData;
  List<ChartData>? chartKEData;

  bool isPaused = false;

  bool turnGraphOn = false;

  late double massOne;
  late double massTwo;

  void initValues() {
    xOne = 0;
    xTwo = AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall - 300;
    // chartPEData = <ChartData>[];
    chartKEData = <ChartData>[];

    xOnePrev = xOne;
    xTwoPrev = xTwo;

    // v1prev = v1;
    // v2prev = v2;

    v1 = 3;
    v2 = 0;

    massOne = 5;
    massTwo = 5;

    q1 = 1;
    q2 = 1;

    calRMinimum();
  }

  void dispose() {
    // chartPEData!.clear();
    chartKEData!.clear();
  }

  // void getPEChartData(double time) {
  //   if (chartPEData!.length > 1000) {
  //     chartPEData = <ChartData>[];
  //   }

  //   double pe = 2000 / (xTwo - xOne);

  //   chartPEData!.add(ChartData(time, pe));
  // }

  void getKEChartData(double time) {
    if (chartKEData!.length > 800) {
      chartKEData = <ChartData>[];
    }

    double ke = -0.5 * massOne * v1 * v1;

    double multiplier = massOne > 500 ? 0.25 : 5;

    chartKEData!.add(ChartData(xOne, multiplier * ke));
  }

  void calRMinimum() {
    double temp1 = 2 * k * q1 * q2;
    double temp2 = massOne * v1 * v1 + massTwo * v2 * v2;
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
    // chartKEData = <ChartData>[];
  }

  void reverseV2() {
    v2 = -v2;
  }

  void updateXOne() {
    xOne += v1 * delT;
  }

  void updateVel() {
    double u1 = v1;
    double a1 = -k * q1 * q2 / ((xTwo - xOne) * (xTwo - xOne) * massOne);
    double a2 = k * q1 * q2 / ((xTwo - xOne) * (xTwo - xOne) * massTwo);

    v1 += a1 * delT;
    // if ((xOne - xOnePrev).abs() < 1) {
    //   v1 += a1 * delT;
    // }
    // if (xOne > xOnePrev) {
    //   v1 += a1 * delT;
    // } else {
    //   v1 -= a1 * delT;
    // }

    if (v1.isNegative != u1.isNegative) {
      // chartKEData = <ChartData>[];
    }

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
    // v1prev = v1;
    // v2prev = v2;
  }

  void updateVelocitiesAfterCollision() {
    double u1 = v1;
    double u2 = v2;
    v1 = ((massOne - massTwo) / (massOne + massTwo)) * u1 + 2 * (massTwo * u2) / (massOne + massTwo);
    v2 = ((massTwo - massOne) / (massOne + massTwo)) * u2 + 2 * (massOne * u1) / (massOne + massTwo);
    double temp1 = xOnePrev;
    double temp2 = xTwoPrev;
    xOnePrev = xOne;
    xTwoPrev = xTwo;
    xOne = temp1;
    xTwo = temp2;
    // chartKEData = <ChartData>[];

    print("vel: u1:$u1, u2:$u2, v1:$v1, v2:$v2");
  }
}

class ChartData {
  ChartData(this.time, this.energy);
  final double time;
  final double energy;
}
