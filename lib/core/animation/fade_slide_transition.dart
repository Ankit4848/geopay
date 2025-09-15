import 'package:flutter/material.dart';

import '../core.dart';

class FadeSlideTransition extends StatefulWidget {
  final Widget child;
  final int? seconds;

  const FadeSlideTransition({super.key, required this.child, this.seconds});

  @override
  State<FadeSlideTransition> createState() => _FadeSlideTransitionState();
}

class _FadeSlideTransitionState extends State<FadeSlideTransition>
    with SingleTickerProviderStateMixin {
  double additionalOffset = 16.0;
  AnimationController? _animationController;
  Animation<double>? _formElementAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        // duration: Duration( seconds: widget.seconds ?? 2),
        duration: Duration(milliseconds: widget.seconds == 1 ? 700 : 1300));
    var fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _formElementAnimation = fadeSlideTween.animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(
          0.45,
          0.8,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _animationController!.forward();
    super.initState();
  }

  @override
  dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    additionalOffset = height > 650 ? kSpaceM : kSpaceS;
    return AnimatedBuilder(
      animation: _formElementAnimation!,
      child: widget.child,
      builder: (_, Widget? builderChild) {
        return Transform.translate(
          offset: Offset(
            0.0,
            (32.0 + additionalOffset) * (1 - _formElementAnimation!.value),
          ),
          child: Opacity(
            opacity: _formElementAnimation!.value,
            child: builderChild,
          ),
        );
      },
    );
  }
}
