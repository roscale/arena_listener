library arena_listener;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:arena_listener/raw_gesture_recognizer.dart';

class ArenaListener extends StatelessWidget {
  const ArenaListener({
    super.key,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerCancel,
    this.onWin,
    this.onLose,
    this.behavior,
    this.excludeFromSemantics = false,
    this.child,
  });

  final GestureDisposition? Function(PointerDownEvent)? onPointerDown;
  final GestureDisposition? Function(PointerMoveEvent, GestureDisposition?)? onPointerMove;
  final GestureDisposition? Function(PointerUpEvent, GestureDisposition?)? onPointerUp;
  final GestureDisposition? Function(PointerCancelEvent, GestureDisposition?)? onPointerCancel;
  final void Function(PointerEvent)? onWin;
  final void Function(PointerEvent)? onLose;

  final HitTestBehavior? behavior;
  final bool excludeFromSemantics;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures = <Type, GestureRecognizerFactory>{};

    if (onPointerDown != null ||
        onPointerMove != null ||
        onPointerUp != null ||
        onPointerCancel != null ||
        onWin != null ||
        onLose != null) {
      gestures[RawGestureRecognizer] = GestureRecognizerFactoryWithHandlers<RawGestureRecognizer>(
        () => RawGestureRecognizer(debugOwner: this),
        (RawGestureRecognizer instance) {
          instance.onPointerDown = onPointerDown;
          instance.onPointerMove = onPointerMove;
          instance.onPointerUp = onPointerUp;
          instance.onPointerCancel = onPointerCancel;
          instance.onWin = onWin;
          instance.onLose = onLose;
        },
      );
    }

    return RawGestureDetector(
      gestures: gestures,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      child: child,
    );
  }
}
