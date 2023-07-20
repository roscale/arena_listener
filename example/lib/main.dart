import 'dart:ui';

import 'package:arena_listener/arena_listener.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class PointData {
  Offset offset;
  Color color;

  PointData(this.offset, this.color);
}

List<PointData> points = [];

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  void addPoint(Offset offset, GestureDisposition? disposition) {
    Color color;
    switch (disposition) {
      case null:
        color = Colors.black;
      case GestureDisposition.accepted:
        color = Colors.red;
      case GestureDisposition.rejected:
        color = Colors.green;
    }

    setState(() {
      points.add(PointData(offset, color));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: ArenaListener(
        onPointerDown: (event) {
          addPoint(event.localPosition, null);
          return null;
        },
        onPointerMove: (event, GestureDisposition? disposition) {
          addPoint(event.localPosition, disposition);
          return null;
        },
        onPointerUp: (event, GestureDisposition? disposition) {
          addPoint(event.localPosition, disposition);
          return GestureDisposition.accepted;
        },
        onWin: (event) {
          addPoint(event.localPosition, GestureDisposition.accepted);
        },
        onLose: (event) {
          addPoint(event.localPosition, GestureDisposition.rejected);
        },
        child: CustomPaint(
          painter: PointPainter(),
          child: ListView.builder(
            itemBuilder: (context, i) {
              return Text("$i");
            },
          ),
        ),
      ),
    );
  }
}

class PointPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.white);

    for (final point in points) {
      canvas.drawPoints(
        PointMode.points,
        [point.offset],
        Paint()
          ..color = point.color
          ..strokeWidth = 10,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
