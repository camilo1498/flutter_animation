import 'dart:ui';

import 'package:animations/pages/expanded_card/curves.dart';
import 'package:flutter/material.dart';

class ExpandableAnimatedContainer extends StatefulWidget {
  /// widget that will show when container is not expand (it shows when the container is expand too)
  final Widget firstChild;
  /// widget that will show when container is expand
  final Widget secondChild;
  /// parent container decoration
  final BoxDecoration? boxDecoration;
  /// animation type, you can use Curves or [ExpandableAnimatedContainerCurves]
  final Curve? curve;
  /// container expandable animation duration
  final Duration animationDuration;
  /// parent container content padding
  final EdgeInsets? padding;

  const ExpandableAnimatedContainer({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    this.boxDecoration,
    this.curve,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.padding
  }) : super(key: key);

  @override
  State<ExpandableAnimatedContainer> createState() => _ExpandableAnimatedContainerState();
}

class _ExpandableAnimatedContainerState extends State<ExpandableAnimatedContainer> with SingleTickerProviderStateMixin{

  /// controllers
  late AnimationController animationController;

  /// variables
  ValueNotifier<bool> expanded = ValueNotifier<bool>(false);
  double currentFirstHeight = 0.0;
  double currentSecondHeight = 0.0;

  /// global keys => it will be use to calculate the first and second child height
  GlobalKey firstKey = GlobalKey();
  GlobalKey secondKey = GlobalKey();

  @override
  void initState() {
    /// init anim controller
    animationController = AnimationController(vsync: this, duration: widget.animationDuration);

    /// get children height
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getChildSize();
    });
    super.initState();
  }

  @override
  void dispose() {
    /// dispose anim controller
    if(mounted) {
      animationController.dispose();
    }
    super.dispose();
  }

  /// calculate child widgets size
  _getChildSize() {
    final RenderBox renderFirst = firstKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox renderSecond = secondKey.currentContext!.findRenderObject() as RenderBox;
    final sizeFirst = renderFirst.size;
    final sizeSecond = renderSecond.size;
    setState(() {
      currentFirstHeight = sizeFirst.height + (widget.padding != null ? widget.padding!.vertical : 10);
      currentSecondHeight = sizeSecond.height;
    });
  }

  /// set container height by curve animation
  double _expandableContainerHeight(double value, double minHeight, double maxHeight) {
    currentFirstHeight = maxHeight;
    if(lerpDouble(maxHeight, minHeight, value)! > 0.0) {
      return lerpDouble(maxHeight, minHeight, value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: expanded,
      builder: (_, expandedVal, __) => AnimatedBuilder(
        animation: animationController,
        builder: (_, __) {
          final double value = (widget.curve ?? ExpandableAnimatedContainerCurves.elasticInOut(period: 0.4)).transform(animationController.value);
          return GestureDetector(
            onTap: () {
              setState(() {
                expanded.value = !expandedVal;
              });
              if(expandedVal) {
                animationController.reverse(from: 1.0);
              } else {
                animationController.forward(from: 0.0);
              }
            },
            child: Container(
              width: size.width,
              height: _expandableContainerHeight(value, currentSecondHeight , currentFirstHeight),
              padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: widget.boxDecoration ?? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 4
                  )
                ]
              ),
              child: ClipRRect(
                borderRadius: widget.boxDecoration != null ? widget.boxDecoration!.borderRadius ?? BorderRadius.circular(10): BorderRadius.circular(10),
                child: SingleChildScrollView(
                  physics: const  NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        key: firstKey,
                        child: widget.firstChild,
                      ),
                      Column(
                        key: secondKey,
                        children: [
                          const SizedBox(height: 10),
                          widget.secondChild
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}