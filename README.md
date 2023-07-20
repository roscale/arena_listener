# arena_listener

GestureDetector is too high level for you?
Wish you had something similar to Listener that could fight with GestureDetectors in gesture arenas?
Then this package is for you!

## Features

- Listen for pointer events, exactly like a Listener.
- Read the gesture disposition (accepted, refused, unresolved) of a pointer.
- Try to resolve the arena (claim victory or admit defeat), or leave it unresolved.
- Get notified when a pointer wins or looses the arena.

## Usage

```dart
import 'package:arena_listener/arena_listener.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ArenaListener(
      onPointerDown: (PointerDownEvent event) {
        print("${event.pointer} down");
        return null;
      },
      onPointerMove: (PointerMoveEvent event, GestureDisposition? disposition) {
        print("${event.pointer} move, $disposition");
        return null;
      },
      onPointerUp: (PointerUpEvent event, GestureDisposition? disposition) {
        print("${event.pointer} up, $disposition");
        return GestureDisposition.accepted;
      },
      onPointerCancel: (PointerCancelEvent event, GestureDisposition? disposition) {
        print("${event.pointer} cancel, $disposition");
        return GestureDisposition.rejected;
      },
      onWin: (PointerEvent lastEvent) {
        print("${lastEvent.pointer} won");
      },
      onLose: (PointerEvent lastEvent) {
        print("${lastEvent.pointer} lost");
      },
      child: GestureDetector(
        onVerticalDragUpdate: (_) {},
        child: Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
```

Note that if the arena is already resolved, the gesture disposition that you return will not change anything.
Claiming victory or admitting defeat only works while the arena is unresolved.

Compile and run `example/` for a more visual demo.

You can also use `RawGestureRecognizer` directly with a `RawGestureDetector` if the widget is not appropriate.
Have a look at `ArenaListener`'s code.