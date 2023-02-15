import 'package:async/async.dart';
import 'package:flutter/material.dart';

class LoadingDot extends StatefulWidget {
  final double size;
  final Color dotColor;

  const LoadingDot({
    Key? key,
    this.size = 20,
    this.dotColor = Colors.white,
  }) : super(key: key);

  @override
  State<LoadingDot> createState() => _LoadingDotState();
}

class _LoadingDotState extends State<LoadingDot> with TickerProviderStateMixin {
  static const _beginTimes = [100, 400, 500, 600, 700, 800];

  final List<AnimationController> _animationControllers = [];
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _opacityAnimations = [];
  final List<CancelableOperation<int>> _delayFutures = [];

  @override
  void initState() {
    super.initState();
    const cubic = Cubic(0.2, 0.68, 0.18, 0.08);

    for (int i = 0; i < 6; ++i) {
      _animationControllers.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1500),
        ),
      );

      _scaleAnimations.add(
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.1), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 0.1, end: 1.0), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 8),
        ]).animate(
          CurvedAnimation(parent: _animationControllers[i], curve: cubic),
        ),
      );

      _opacityAnimations.add(
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 8),
        ]).animate(
          CurvedAnimation(parent: _animationControllers[i], curve: cubic),
        ),
      );

      _delayFutures.add(
        CancelableOperation.fromFuture(
          Future.delayed(Duration(milliseconds: _beginTimes[i])).then((_) {
            _animationControllers[i].repeat();
            return 0;
          }),
        ),
      );
    }
  }

  @override
  void dispose() {
    for (final f in _animationControllers) {
      f.dispose();
    }
    for (final f in _delayFutures) {
      f.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = List<Widget>.filled(6, Container());
    for (int i = 0; i < 6; i++) {
      widgets[i] = FadeTransition(
        opacity: _opacityAnimations[i],
        child: ScaleTransition(
          scale: _scaleAnimations[i],
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.dotColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets[0],
          const SizedBox(width: 5),
          widgets[1],
          const SizedBox(width: 5),
          widgets[2],
          const SizedBox(width: 5),
          widgets[3],
          const SizedBox(width: 5),
          widgets[4],
          const SizedBox(width: 5),
          widgets[5],
        ],
      ),
    );
  }
}
