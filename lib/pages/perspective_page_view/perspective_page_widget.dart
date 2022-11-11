import 'package:flutter/material.dart';

class AnimatedPerspectivePage extends StatefulWidget {
  final List<Widget> child;
  final double childAspectRatio;
  final double pageAspectRatio;
  final PageController pageController;
  const AnimatedPerspectivePage({
    Key? key,
    required this.child,
    required this.pageController,
    this.childAspectRatio = 0.7,
    this.pageAspectRatio = 1.0,
  }) : super(key: key);

  @override
  State<AnimatedPerspectivePage> createState() => _AnimatedPerspectivePageState();
}

class _AnimatedPerspectivePageState extends State<AnimatedPerspectivePage> {

  /// controller
  late PageController _pageController;


  /// save page offset
  ValueNotifier<double> pageOffset = ValueNotifier<double>(2.0);


  @override
  void initState() {
    _pageController = widget.pageController;

    /// listen page offset
    _pageController.addListener(() {
      pageOffset.value = _pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    /// close listeners
    if(mounted) {
      _pageController.dispose();
      pageOffset.dispose();
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