import 'package:flutter/material.dart';

class SlideIndexedStack extends StatefulWidget {
  final int index;
  final double slideOffset;
  final List<Widget> children;
  final Duration duration;

  const SlideIndexedStack({
    Key? key,
    required this.index,
    this.slideOffset = 0.2,
    required this.children,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<SlideIndexedStack> createState() => _SlideIndexedStackState();
}

class _SlideIndexedStackState extends State<SlideIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<Offset> _slideRTL;
  late final Animation<Offset> _slideLTR;

  bool _isRTL = true;

  Animation<Offset> _getAnimationIn() {
    return Tween(begin: Offset(widget.slideOffset, 0), end: Offset.zero)
        .animate(_animationController);
  }

  Animation<Offset> _getAnimationOut() {
    return Tween(begin: Offset(-widget.slideOffset, 0), end: Offset.zero)
        .animate(_animationController);
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _slideRTL = _getAnimationIn();
    _slideLTR = _getAnimationOut();
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant SlideIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      bool checkRTL = false;
      if (widget.index > oldWidget.index) {
        checkRTL = true;
      }
      setState(() {
        _isRTL = checkRTL;
      });
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: _isRTL ? _slideRTL : _slideLTR,
          child: child,
        );
      },
      child: LazyIndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}

class LazyIndexedStack extends StatefulWidget {
  /// Widget to be built when not loaded. Default widget is [Container].
  late final Widget unloadWidget;

  /// Same as alignment attribute of original IndexedStack.
  final AlignmentGeometry alignment;

  /// Same as sizing attribute of original IndexedStack.
  final StackFit sizing;

  /// Same as textDirection attribute of original IndexedStack.
  final TextDirection? textDirection;

  /// The index of the child to show.
  final int index;

  /// The widgets below this widget in the tree.
  ///
  /// A child widget will not be built until the index associated with it is specified.
  /// When the index associated with the widget is specified again, the built widget is returned.
  final List<Widget> children;

  /// Creates LazyLoadIndexedStack that wraps IndexedStack.
  LazyIndexedStack({
    Key? key,
    Widget? unloadWidget,
    this.alignment = AlignmentDirectional.topStart,
    this.sizing = StackFit.loose,
    this.textDirection,
    required this.index,
    required this.children,
  }) : super(key: key) {
    this.unloadWidget = unloadWidget ?? Container();
  }

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<Widget> _children;
  final _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _children = _initialChildren();
  }

  @override
  void didUpdateWidget(final LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    _children[widget.index] = widget.children[widget.index];
  }

  @override
  Widget build(final BuildContext context) {
    return IndexedStack(
      key: _stackKey,
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: _children,
    );
  }

  List<Widget> _initialChildren() {
    return widget.children.asMap().entries.map((entry) {
      final index = entry.key;
      final childWidget = entry.value;
      return index == widget.index ? childWidget : widget.unloadWidget;
    }).toList();
  }
}
