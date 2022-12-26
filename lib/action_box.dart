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
  late double time;
  // ChartSeriesController? _chartPESeriesController;
  ChartSeriesController? _chartKESeriesController;
  late double graphscale;

  void _updateDataSource() {
    // _actionsView.getPEChartData(time);
    _actionsView.getKEChartData(time);

    // if (_actionsView.chartPEData!.isNotEmpty) {
    //   _chartPESeriesController?.updateDataSource(
    //     addedDataIndex: _actionsView.chartPEData!.length - 1,
    //   );
    // }

    if (_actionsView.chartKEData!.isNotEmpty) {
      _chartKESeriesController?.updateDataSource(
        addedDataIndex: _actionsView.chartKEData!.length - 1,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _actionsView = context.read(actionsViewProvider);
    _actionsView.initValues(5, 5, 3, 3);
    graphscale = -200;
    // _actionsView.calRMinimum();
    time = 0;
    timer = Timer.periodic(const Duration(milliseconds: 17), (Timer t) {
      if (_actionsView.isPaused) {
      } else {
        _updateDataSource();
        time += 1;
        setState(() {
          // _actionsView.getChartData(time);

          _actionsView.updatePreviousValues();

          //checking edge case for sphere 1
          if (_actionsView.xOne >
              AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV1();
          }
          if (_actionsView.xOne < 0) {
            _actionsView.reverseV1();
          }
          _actionsView.updateXOne();

          // checking edge case for sphere 2
          if (_actionsView.xTwo >
              AppConfigs.widthOfActionBox - AppConfigs.sizeOfBall) {
            _actionsView.reverseV2();
          }
          if (_actionsView.xTwo < 0) {
            _actionsView.reverseV2();
          }
          _actionsView.updateXTwo();

          // checking if collision is happening
          if ((_actionsView.xOne - _actionsView.xTwo).abs() <
              AppConfigs.sizeOfBall) {
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
    // _chartPESeriesController = null;
    _chartKESeriesController = null;

    _actionsView.dispose();
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _actionsView.initValues(1, 1000, 3, 0);
                  graphscale = -50;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(30)),
                width: 30,
                height: 30,
                child: const Center(
                    child: Text("1", style: TextStyle(fontSize: 15))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _actionsView.initValues(5, 5, 3, 0);
                  graphscale = -150;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(30)),
                width: 30,
                height: 30,
                child: const Center(
                    child: Text("2", style: TextStyle(fontSize: 15))),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _actionsView.initValues(100, 1, 3, 0);
                  graphscale = -3200;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(30)),
                width: 30,
                height: 30,
                child: const Center(
                    child: Text("3", style: TextStyle(fontSize: 15))),
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(15),
          child: Text(
              "M1: ${_actionsView.massOne}, M2: ${_actionsView.massTwo}, V1: ${_actionsView.v1.toStringAsFixed(2)}, V2: ${_actionsView.v2.toStringAsFixed(2)}, Collision: ${_actionsView.rmin < 30 ? true : false}"),
        ),
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
        if (_actionsView.turnGraphOn)
          Container(
              margin: const EdgeInsets.only(left: 80),
              width: AppConfigs.widthOfActionBox + 220,
              child: _buildAnimationSplineChart()),
        const SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            _actionsView.turnGraphOn = !_actionsView.turnGraphOn;
          },
          child: Text(
            _actionsView.turnGraphOn ? "Turn Off Graph" : "Turn On Graph ",
            style: GoogleFonts.poppins(
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }

  /// get the spline chart sample with dynamically updated data points.
  SfCartesianChart _buildAnimationSplineChart() {
    return SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: Legend(
            isVisible: true,
            // Border color and border width of legend
            borderColor: Colors.black,
            borderWidth: 2),
        primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            maximum: AppConfigs.widthOfActionBox,
            minimum: 0,
            labelStyle: const TextStyle(
              color: Colors.transparent,
            ),
            title: AxisTitle(
              text: 'Position',
              textStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
            )),
        primaryYAxis: NumericAxis(
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLine: const AxisLine(width: 0),
          minimum: graphscale,
          maximum: 0,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          title: AxisTitle(
            text: '- KE Energy',
            textStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
          ),
        ),
        series: _getDefaultSplineSeries());
  }

  /// get the spline series sample with dynamically updated data points.
  List<SplineSeries<ChartData, num>> _getDefaultSplineSeries() {
    return <SplineSeries<ChartData, num>>[
      // SplineSeries<ChartData, num>(
      //     dataSource: _actionsView.chartPEData!,
      //     name: "Potential Energy",
      //     onRendererCreated: (ChartSeriesController controller) {
      //       _chartPESeriesController = controller;
      //     },
      //     animationDuration: 0,
      //     xValueMapper: (ChartData sales, _) => sales.time,
      //     yValueMapper: (ChartData sales, _) => sales.energy,
      //     markerSettings: const MarkerSettings(isVisible: false)),
      SplineSeries<ChartData, num>(
          dataSource: _actionsView.chartKEData!,
          name: "Kinetic Energy",
          onRendererCreated: (ChartSeriesController controller) {
            _chartKESeriesController = controller;
          },
          animationDuration: 0,
          xValueMapper: (ChartData sales, _) => sales.time,
          yValueMapper: (ChartData sales, _) => sales.energy,
          markerSettings: const MarkerSettings(isVisible: false))
    ];
  }
}
