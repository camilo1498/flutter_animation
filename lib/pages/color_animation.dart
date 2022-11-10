import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpandableNavBar extends StatefulWidget {
  const ExpandableNavBar({Key? key}) : super(key: key);

  @override
  State<ExpandableNavBar> createState() => _ExpandableNavBarState();
}

const double maxHeight = 350.0;
const double minHeight = 70.0;

class _ExpandableNavBarState extends State<ExpandableNavBar> with SingleTickerProviderStateMixin{

  late AnimationController animController;

  final ScreenUtil screenUtil = ScreenUtil();

  bool expanded = false;
  double currentHeight = 0.0;

  @override
  void initState() {
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800)
    );
    super.initState();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double menuWidth = screenUtil.screenWidth * 0.5;
    return Scaffold(
      body: Container(),
      bottomNavigationBar: GestureDetector(
        onVerticalDragUpdate: expanded ? (details) {
          setState(() {
            final newHeight = currentHeight - details.delta.dy;
            animController.value = currentHeight / maxHeight;
            currentHeight = newHeight.clamp(minHeight, maxHeight);
          });
        } : null,
        onVerticalDragEnd: expanded ? (details) {
          if(currentHeight < maxHeight / 1.5) {
             animController.reverse();
             expanded = false;
          } else {
            expanded = true;
            animController.forward(from: currentHeight / maxHeight);
            currentHeight = maxHeight;
          }
        } : null,
        child: AnimatedBuilder(
          animation: animController,
          builder: (context, child) {
            final value = const ElasticInOutCurve(0.7).transform(animController.value);
            return Stack(
              children: [
                Positioned(
                  height: lerpDouble(minHeight, currentHeight, value),
                  left: lerpDouble((screenUtil.screenWidth / 2) - (menuWidth / 2), 0, value),
                  width: lerpDouble(menuWidth, screenUtil.screenWidth, value),
                  bottom: lerpDouble(40.0, 0.0, value),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.vertical(
                            top: const Radius.circular(20),
                          bottom: Radius.circular(lerpDouble(20.0, 0.0, value) ?? 0.0)
                        )
                    ),
                    child: expanded ? Opacity(
                      opacity: animController.value,
                      child: _expandedWidget(),
                    ) : Opacity(
                      opacity: 1 - animController.value,
                      child: _nonExpandedWidget(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _nonExpandedWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 30,
          height: 30,
          color: Colors.white,
        ),

        GestureDetector(
          onTap: () {
            setState(() {
              currentHeight = maxHeight;
              animController.forward(from: 0.0).then((value) {
                setState(() {
                  expanded = true;
                });
              });
            });
          },
          child: Container(
            width: 30,
            height: 30,
            color: Colors.white,
          ),
        ),

        Container(
          width: 30,
          height: 30,
          color: Colors.white,
        )
      ],
    );
  }

  Widget _expandedWidget() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 300,
              width: screenUtil.screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}