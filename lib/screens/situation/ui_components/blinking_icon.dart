import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final Widget child;
  final bool blinking;

  const BlinkingIcon({
    Key key,
    @required this.child,
    @required this.blinking,
  }) : super(key: key);

  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    if (widget.blinking) {
      _animationController.repeat(reverse: true);
    } else {
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: widget.child,
    );
  }
}
