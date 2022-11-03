import 'dart:ui';

import 'package:animations/data/models/search_image_res.dart';
import 'package:flutter/material.dart';
import 'dart:math' ;

class Card3DItem extends AnimatedWidget {
  const Card3DItem({
    Key? key,
    this.photo,
    this.percent = 0.0,
    this.height = 300,
    this.index,
    this.onCardSelected,
    this.verticalFactor = 0,
    this.isForward = false,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  final Photo? photo;
  final double percent;
  final double height;
  final int? index;
  final ValueChanged<Photo>? onCardSelected;
  final int verticalFactor;
  final bool isForward;

  @override
  Widget build(BuildContext context) {

    final bottomMargin = height / 6.0;

    return Positioned(
      left: 0,
      right: 0,
      top: height + -index! * height / 2.0 * percent - bottomMargin,
      child: Card3DWidget(
        animation: animation,
        verticalFactor: verticalFactor,
        height: height,
        onCardSelected: onCardSelected,
        index: index,
        isForward: isForward,
        percent: percent,
        photo: photo,
      ),
    );
  }
}

class Card3DWidget extends AnimatedWidget {
  final Photo? photo;
  final double percent;
  final double height;
  final int? index;
  final ValueChanged<Photo>? onCardSelected;
  final int verticalFactor;
  final bool isForward;
  const Card3DWidget({
    Key? key,
    this.photo,
    this.percent = 0.0,
    this.height = 300,
    this.index,
    this.onCardSelected,
    this.verticalFactor = 0,
    this.isForward = false,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    const depthFactor = 50.0;
    return Opacity(
      opacity:
      verticalFactor == 0 ? 1 : (isForward ? (1 - animation.value) : 1.0),
      child: Hero(
        tag: index.toString(),
        flightShuttleBuilder: (context, animation, flighDirection,
            fromHeroContext, toHeroContext) {
          Widget current;
          double depth = 0.0;

          if (flighDirection == HeroFlightDirection.push) {
            current = toHeroContext.widget;
          } else {
            current = fromHeroContext.widget;
            depth = index! * lerpDouble(0.0, depthFactor, animation.value)!;
          }

          return AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final newValue = lerpDouble(0.5, 2 * pi, animation.value)!;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0,
                      -verticalFactor * animation.value * height,
                      depth)
                  ..rotateX(newValue),
                child: current,
              );
            },
          );
        },
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..translate(
              0.0,
              verticalFactor *
                  -animation.value *
                  height,
              index! * depthFactor,
            ),
          child: GestureDetector(
            onTap: () {
              onCardSelected!(photo!);
            },
            child:  SizedBox(
              height: height,
              child: PhysicalModel(
                elevation: 6,
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    photo!.src!.medium!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}