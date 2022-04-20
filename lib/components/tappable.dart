import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class Tappable extends StatefulWidget {
  Tappable({
    required this.child,
    this.tapOpacity = 0.25,
    this.fadeInDuration = const Duration(milliseconds: 1000),
    this.fadeOutDuration = const Duration(milliseconds: 2),
    this.fadeInCurve,
    this.fadeOutCurve,
    this.onTap,
    this.onLongTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onDoubleTapDown,
    this.onDoubleTap,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.behavior = HitTestBehavior.translucent,
  });

  final Widget child;
  final double tapOpacity;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  Curve? fadeInCurve;
  Curve? fadeOutCurve;
  final Function()? onTap;
  final Function()? onLongTap;
  final Function(TapDownDetails)? onTapDown;
  final Function(TapUpDetails)? onTapUp;
  final Function()? onTapCancel;
  final Function(TapDownDetails)? onDoubleTapDown;
  final Function()? onDoubleTap;
  final Function()? onDoubleTapCancel;
  final Function(LongPressDownDetails)? onLongPressDown;
  final Function()? onLongPressCancel;
  final Function()? onLongPress;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(LongPressMoveUpdateDetails)? onLongPressMoveUpdate;
  final Function()? onLongPressUp;
  final Function(LongPressEndDetails)? onLongPressEnd;
  final Function(DragDownDetails)? onVerticalDragDown;
  final Function(DragStartDetails)? onVerticalDragStart;
  final Function(DragUpdateDetails)? onVerticalDragUpdate;
  final Function(DragEndDetails)? onVerticalDragEnd;
  final Function()? onVerticalDragCancel;
  final Function(DragDownDetails)? onHorizontalDragDown;
  final Function(DragStartDetails)? onHorizontalDragStart;
  final Function(DragUpdateDetails)? onHorizontalDragUpdate;
  final Function(DragEndDetails)? onHorizontalDragEnd;
  final Function()? onHorizontalDragCancel;
  final Function(DragDownDetails)? onPanDown;
  final Function(DragStartDetails)? onPanStart;
  final Function(DragUpdateDetails)? onPanUpdate;
  final Function(DragEndDetails)? onPanEnd;
  final Function()? onPanCancel;
  final HitTestBehavior behavior;
  @override
  State<Tappable> createState() => _TappableState();
}

const Duration fadeOutDuration = Duration(milliseconds: 1);

class _TappableState extends State<Tappable> {
  double opacity = 1;
  Duration fadeDuration = fadeOutDuration;
  @override
  Widget build(BuildContext context) {
    widget.fadeInCurve ??= Sprung.overDamped.flipped;
    widget.fadeOutCurve ??= Sprung.overDamped;
    Curve curve = widget.fadeOutCurve as Curve;
    return Listener(
      behavior: widget.behavior,
      child: GestureDetector(
        behavior: widget.behavior,
        child: AnimatedOpacity(
          child: widget.child,
          opacity: opacity,
          duration: fadeDuration,
          curve: curve,
        ),
        onTapCancel: () {
          setState(() {
            fadeDuration = widget.fadeInDuration;
            curve = widget.fadeInCurve as Curve;
            opacity = 1;

            if (widget.onTapCancel != null) {
              widget.onTapCancel!();
            }
          });
          // print('cancel');
        },
        onTapDown: widget.onTapDown,
        onTapUp: widget.onTapUp,
        onTap: widget.onTap,
        onDoubleTapDown: widget.onDoubleTapDown,
        onDoubleTap: widget.onDoubleTap,
        onDoubleTapCancel: widget.onDoubleTapCancel,
        onLongPressDown: widget.onLongPressDown,
        onLongPressCancel: widget.onLongPressCancel,
        onLongPress: widget.onLongPress,
        onLongPressStart: widget.onLongPressStart,
        onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
        onLongPressUp: widget.onLongPressUp,
        onLongPressEnd: widget.onLongPressEnd,
        onVerticalDragDown: widget.onVerticalDragDown,
        onVerticalDragStart: widget.onVerticalDragStart,
        onVerticalDragUpdate: widget.onVerticalDragUpdate,
        onVerticalDragEnd: widget.onVerticalDragEnd,
        onVerticalDragCancel: widget.onVerticalDragCancel,
        onHorizontalDragDown: widget.onHorizontalDragDown,
        onHorizontalDragStart: widget.onHorizontalDragStart,
        onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
        onHorizontalDragEnd: widget.onHorizontalDragEnd,
        onHorizontalDragCancel: widget.onHorizontalDragCancel,
        onPanDown: widget.onPanDown,
        onPanStart: widget.onPanStart,
        onPanUpdate: widget.onPanUpdate,
        onPanEnd: widget.onPanEnd,
        onPanCancel: widget.onPanCancel,
      ),
      onPointerDown: (details) {
        setState(
          () {
            fadeDuration = fadeOutDuration;
            opacity = widget.tapOpacity;
            curve = widget.fadeOutCurve as Curve;
          },
        );
      },
      onPointerUp: (details) {
        setState(
          () {
            fadeDuration = widget.fadeInDuration;
            opacity = 1;
            curve = widget.fadeInCurve as Curve;
          },
        );
      },
    );
  }
}
