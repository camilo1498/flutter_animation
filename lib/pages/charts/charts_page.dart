import 'dart:math';

import 'package:animations/pages/charts/widgets/bar.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> with TickerProviderStateMixin{
  static const size = Size(200.0, 100.0);
  final random = Random();
  late AnimationController animation;
  late BarChartTween tween;


  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    tween = BarChartTween(
      BarChart.empty(size),
      BarChart.random(size, random),
    );
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void changeData() {
    setState(() {
      tween = BarChartTween(
        tween.evaluate(animation),
        BarChart.random(size, random),
      );
      animation.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: size,
          painter: BarChartPainter(tween.animate(animation)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
