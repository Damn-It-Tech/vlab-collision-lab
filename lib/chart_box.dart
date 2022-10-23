// /// Dart imports
// import 'dart:async';
// import 'dart:math';

// /// Package import
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// /// Chart import
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:vlab1/actions_view.dart';
// import 'package:vlab1/app_config.dart';
// import 'package:vlab1/providers.dart';

// class AnimationSplineDefault extends StatefulWidget {
//   const AnimationSplineDefault({Key? key}) : super(key: key);

//   @override
//   State<AnimationSplineDefault> createState() => _AnimationSplineDefaultState();
// }

// class _AnimationSplineDefaultState extends State<AnimationSplineDefault> {
//   List<_ChartData>? _chartData;
//   late ActionsView _actionsView;
//   Timer? _timer;

//   @override
//   void initState() {
//     _actionsView = context.read(actionsViewProvider);
//     _chartData = <_ChartData>[];
//     _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
//       if (_actionsView.isPaused) {
//       } else {
//         setState(() {
//           _getChartData(t.tick);
//         });
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(width: AppConfigs.widthOfActionBox, child: _buildAnimationSplineChart());
//   }

//   /// get the spline chart sample with dynamically updated data points.
//   SfCartesianChart _buildAnimationSplineChart() {
//     return SfCartesianChart(
//         plotAreaBorderWidth: 0,
//         primaryXAxis: NumericAxis(majorGridLines: const MajorGridLines(width: 0)),
//         primaryYAxis: NumericAxis(
//             majorTickLines: const MajorTickLines(color: Colors.transparent),
//             axisLine: const AxisLine(width: 0),
//             minimum: 0,
//             maximum: 100),
//         series: _getDefaultSplineSeries());
//   }

//   /// get the spline series sample with dynamically updated data points.
//   List<SplineSeries<_ChartData, num>> _getDefaultSplineSeries() {
//     return <SplineSeries<_ChartData, num>>[
//       SplineSeries<_ChartData, num>(
//           dataSource: _chartData!,
//           animationDuration: 0,
//           xValueMapper: (_ChartData sales, _) => sales.time,
//           yValueMapper: (_ChartData sales, _) => sales.pe,
//           markerSettings: const MarkerSettings(isVisible: false))
//     ];
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _chartData!.clear();
//     super.dispose();
//   }

//   //Get the random data points
//   void _getChartData(int tick) {
//     // _chartData = <_ChartData>[];

//     if (_chartData!.length > 1000) {
//       _chartData = <_ChartData>[];
//     }

//     double time = tick * 0.01;

//     double pe = 2000 / (_actionsView.xTwo - _actionsView.xOne);

//     _chartData!.add(_ChartData(time, pe));
//     // for (double i = 0; i < 11; i++) {
//     //   _chartData!.add(_ChartData(i, _getRandomDouble(15, 85)));
//     // }
//   }
// }

// class _ChartData {
//   _ChartData(this.time, this.pe);
//   final double time;
//   final double pe;
// }
