import 'package:animations/pages/scroll_tab_bar/perspective_page_widget.dart';
import 'package:animations/pages/scroll_tab_bar/perpective_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PerspectivePage extends StatelessWidget {
  const PerspectivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PerspectiveController>(
      id: 'photo_list',
      builder: (ctrl) => Scaffold(
          body: ctrl.photoList.isNotEmpty ? Center(
            child: AnimatedPerspectivePage(
              child: [
                ...ctrl.photoList.map((item) => Hero(
                  tag: ctrl.photoList.indexOf(item).toString(),
                  child: GestureDetector(
                    onTap: () => ctrl.onTapItem(ctrl.photoList.indexOf(item)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(0, 1),
                                blurRadius: 0.1,
                                spreadRadius: 1
                            )
                          ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          image: NetworkImage(item.src!.medium!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ) : const Center(
          child: CircularProgressIndicator(),
    ),
    )
    );
  }
}


class Card extends StatelessWidget {
  final int number;
  final double aspectRatio;
  final Widget child;
  final Color? shadowColor;
  final bool hasShadow;
  final double shadowScale;
  final double value;

  const Card({
    super.key,
    required this.child,
    required this.number,
    required this.aspectRatio,
    this.hasShadow = false,
    this.shadowColor,
    required this.shadowScale,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    double diff = (number - value);

    final Matrix4 pvMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9)
      ..setEntry(1, 1, aspectRatio)
      ..setEntry(3, 0, 0.004 * -diff);

    final Matrix4 shadowMatrix = Matrix4.identity()
      ..setEntry(3, 3, 1 / shadowScale)
      ..setEntry(3, 1, -0.004)
      ..setEntry(3, 0, 0.002 * diff)
      ..rotateX(1.309);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: <Widget>[
        if (hasShadow && diff <= 1.0 && diff >= -1.0) ...[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: 1 - diff.abs(),
            child: Transform(
              alignment: FractionalOffset.bottomCenter,
              transform: shadowMatrix,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(color: shadowColor??Colors.black12, blurRadius: 10.0, spreadRadius: 1.0)
                ]),
              ),
            ),
          ),
        ],
        Transform(
          transform: pvMatrix,
          alignment: FractionalOffset.center,
          child: Container(
            child: child,
          ),
        ),
      ],
    );
  }
}

class Controller extends ChangeNotifier {
  double _holder = 2.0;

  double get holder => _holder;

  set holder(double value) {
    _holder = value;
    notifyListeners();
  }
}