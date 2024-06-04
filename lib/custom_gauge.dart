//RIZKY AGUNG NURBASKORO  
//213925

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomGauge extends StatelessWidget {
  final String title;
  final double value;
  final String unit;
  final double maxValue;

  CustomGauge({
    required this.title,
    required this.value,
    required this.unit,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    double effectiveMaxValue = maxValue > 0 ? maxValue : 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 150,
          height: 150,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0,
                maximum: effectiveMaxValue,
                ranges: [
                  GaugeRange(
                    startValue: 0,
                    endValue: effectiveMaxValue * 0.5,
                    color: Colors.green,
                  ),
                  GaugeRange(
                    startValue: effectiveMaxValue * 0.5,
                    endValue: effectiveMaxValue * 0.75,
                    color: Colors.orange,
                  ),
                  GaugeRange(
                    startValue: effectiveMaxValue * 0.75,
                    endValue: effectiveMaxValue,
                    color: Colors.red,
                  ),
                ],
                pointers: [
                  NeedlePointer(
                    value: value,
                  ),
                ],
                annotations: [
                  GaugeAnnotation(
                    widget: Container(
                      child: Text(
                        '$value $unit',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.75,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
