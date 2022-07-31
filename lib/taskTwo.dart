import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TaskTwo extends StatefulWidget {
  const TaskTwo({Key? key}) : super(key: key);

  @override
  State<TaskTwo> createState() => _TaskTwoState();
}

class _TaskTwoState extends State<TaskTwo> {
  num delta = 0;
  double speedOnX = 0;
  double speedOnY = 0;

  Widget _getRadialGauge(String name, num value) {
    return SfRadialGauge(
        title: GaugeTitle(
            text: name,
            textStyle:
                const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 30, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 10,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 10,
                endValue: 20,
                color: Colors.orange,
                startWidth: 10,
                endWidth: 10),
            GaugeRange(
                startValue: 20,
                endValue: 30,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10)
          ], pointers: <GaugePointer>[
            NeedlePointer(value: value.toDouble())
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Container(
                    child: Text('',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold))),
                angle: 1,
                positionFactor: 0.5)
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            Expanded(child: _getRadialGauge("Speed", delta)),
            Expanded(child: _getRadialGauge("Speed On X", speedOnX)),
            Expanded(child: _getRadialGauge("Speed On Y", speedOnY)),
          ],
        ),
        GestureDetector(
          onPanStart: (DragStartDetails details) {},
          onPanUpdate: (DragUpdateDetails details) {
            speedOnX = details.delta.dx;
            speedOnY = details.delta.dy;
            delta = sqrt(pow(speedOnX, 2) + pow(speedOnY, 2));
            delta *= (delta < 0 ? -1 : 1);
            speedOnX *= (speedOnX < 0 ? -1 : 1);
            speedOnY *= (speedOnY < 0 ? -1 : 1);
            setState(() {});
            print("sdfsd : " + details.delta.toString());
          },
          onPanCancel: () {
            delta = 0;
            speedOnX = 0;
            speedOnY = 0;
          },
        ),
      ],
    ));
  }
}


 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
    );
  }
}*/

