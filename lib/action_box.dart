import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vlab1/actions_view.dart';
import 'package:vlab1/app_config.dart';
import 'package:vlab1/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class ActionBox extends StatefulWidget {
  const ActionBox({Key? key}) : super(key: key);

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  Timer? timer;
  late ActionsView _actionsView;
  List<_ChartData>? _chartData;

  @override
  void initState() {
    super.initState();
    _actionsView = context.read(actionsViewProvider);
    _chartData = <_ChartData>[];
    _actionsView.initValues();
    _actionsView.calRMinimum();
    timer = Timer.periodic(const Duration(milliseconds: 17), (Timer t) {
      if (_actionsView.isPaused) {
      } else {
        setState(() {
          _getChartData(t.tick);

          _actionsView.updatePreviousValues();

          //checking edge case for sphere 1
          if (_actionsView.xOne > AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV1();
          }
          if (_actionsView.xOne < 0) {
            _actionsView.reverseV1();
          }
          _actionsView.updateXOne();

          // checking edge case for sphere 2
          if (_actionsView.xTwo > AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV2();
          }
          if (_actionsView.xTwo < 0) {
            _actionsView.reverseV2();
          }
          _actionsView.updateXTwo();

          // checking if collision is happening
          if ((_actionsView.xOne - _actionsView.xTwo).abs() < AppConfigs.sizeOfBall) {
            //use equations and give v1 and v2 new values
            _actionsView.updateVelocitiesAfterCollision();
          }

          _actionsView.updateVel();
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _chartData!.clear();
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
    return Column(
      children: [
        Stack(
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
        ),
        SizedBox(width: AppConfigs.widthOfActionBox, child: _buildAnimationSplineChart())
      ],
    );
  }

  /// get the spline chart sample with dynamically updated data points.
  SfCartesianChart _buildAnimationSplineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            labelStyle: const TextStyle(
              color: Colors.transparent,
            ),
            title: AxisTitle(
              text: 'Time',
              textStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
            )),
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: const AxisLine(width: 0),
          minimum: 0,
          maximum: 100,
          labelStyle: const TextStyle(
            color: Colors.transparent,
          ),
          title: AxisTitle(
            text: 'PE',
            textStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
          ),
        ),
        series: _getDefaultSplineSeries());
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<_ChartData, num>> _getDefaultSplineSeries() {
    return <SplineSeries<_ChartData, num>>[
      SplineSeries<_ChartData, num>(
          dataSource: _chartData!,
          animationDuration: 0,
          xValueMapper: (_ChartData sales, _) => sales.time,
          yValueMapper: (_ChartData sales, _) => sales.pe,
          markerSettings: const MarkerSettings(isVisible: false))
    ];
  }

  //Get the random data points
  void _getChartData(int tick) {
    // _chartData = <_ChartData>[];

    if (_chartData!.length > 1000) {
      _chartData = <_ChartData>[];
    }

    double time = tick / 60;

    double pe = 2000 / (_actionsView.xTwo - _actionsView.xOne);

    _chartData!.add(_ChartData(time, pe));
  }
}

class _ChartData {
  _ChartData(this.time, this.pe);
  final double time;
  final double pe;
}
