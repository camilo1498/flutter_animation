import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedPerspectivePage extends StatefulWidget {
  final List<Widget> child;
  final double childAspectRatio;
  final double pageAspectRatio;
  final double viewPortFraction;
  final Function(ValueNotifier<double>) currentPageIndex;
  const AnimatedPerspectivePage({
    Key? key,
    required this.child,
    required this.currentPageIndex,
    this.childAspectRatio = 0.7,
    this.pageAspectRatio = 1.0,
    this.viewPortFraction = 0.4
  }) : super(key: key);

  @override
  State<AnimatedPerspectivePage> createState() => _AnimatedPerspectivePageState();
}

class _AnimatedPerspectivePageState extends State<AnimatedPerspectivePage> {

  /// controller
  late PageController _pageController;
  Timer? _timer;

  /// save page offset
  ValueNotifier<double> pageOffset = ValueNotifier<double>(2.0);


  @override
  void initState() {
    _pageController = PageController(
        initialPage: 2,
        viewportFraction: widget.viewPortFraction
    );
    /// listen page offset
    _pageController.addListener(() {
      pageOffset.value = _pageController.page!;
      if(_timer != null) {
        _timer!.cancel();
      }
      _timer = Timer(const Duration(milliseconds: 100), () {
        widget.currentPageIndex(ValueNotifier<double>(pageOffset.value));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    /// close listeners
    if(mounted) {
      _pageController.dispose();
      pageOffset.dispose();
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageOffset,
      builder: (ctx, ctrl, child) {
          return AspectRatio(
            aspectRatio: widget.pageAspectRatio,
            child: PageView(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              children: widget.child.map((item) => _FractionalCard(
                  index: widget.child.indexOf(item),
                  value: pageOffset.value,
                  aspectRatio: widget.childAspectRatio,
                  child: item,
                )).toList(),
            ),
          );
      },
    );
  }
}

class _FractionalCard extends StatelessWidget {
  final int index;
  final double aspectRatio;
  final Widget child;
  final double value;

  const _FractionalCard({
    required this.child,
    required this.index,
    required this.aspectRatio,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    double diff = (index - value);

    /// matrix transform
    final Matrix4 transformPerspective = Matrix4.identity()
      ..setEntry(3, 3, 1 / 0.9)
      ..setEntry(1, 1, aspectRatio)
      ..setEntry(3, 0, 0.004 * -diff);

    return Transform(
      transform: transformPerspective,
      alignment: FractionalOffset.center,
      child: SizedBox(
        child: child,
      ),
    );
  }
}