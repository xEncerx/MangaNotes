import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SwipeableContent extends StatefulWidget {
  final Widget child;
  const SwipeableContent({super.key, required this.child});

  @override
  State<SwipeableContent> createState() => _SwipeableContentState();
}

class _SwipeableContentState extends State<SwipeableContent>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late Animation _animation;
  double _dx = 0;

  @override
  void initState() {
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() => setState(() => _dx = _animation.value));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => _onPanUpdate(details),
      onPanEnd: (details) => _onPanEnd(details),
      child: Transform.translate(
        offset: Offset(_dx, 0),
        child: widget.child,
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_dx + details.delta.dx >= 0) {
      setState(() => _dx += details.delta.dx);
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dx > MediaQuery.of(context).size.width * 0.3) {
      context.router.maybePop();
    } else {
      _animation = Tween<double>(begin: _dx, end: 0).animate(_controller);
      _controller.forward(from: 0);
    }
  }
}
