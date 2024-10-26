import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SwipeableContent extends StatefulWidget {
  final Widget child;
  const SwipeableContent({super.key, required this.child});

  @override
  State<SwipeableContent> createState() => _SwipeableContentState();
}

class _SwipeableContentState extends State<SwipeableContent> {
  double _dx = 0;

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
    if (details.delta.dx > 0) {
      setState(() => _dx += details.delta.dx);
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_dx > MediaQuery.of(context).size.width * 0.2) {
      context.router.maybePop();
    } else {
      setState(() => _dx = 0);
    }
  }
}
