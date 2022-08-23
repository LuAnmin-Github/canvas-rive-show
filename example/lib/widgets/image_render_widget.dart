import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CanvasDrawImage extends LeafRenderObjectWidget {
  const CanvasDrawImage(
    this.imageFrame, {
    Key? key,
  }) : super(key: key);

  final ui.Image? imageFrame;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCanvasDrawImage(
      imageFrame: imageFrame,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCanvasDrawImage renderObject) {
    renderObject.imageFrame = imageFrame;
  }
}

/// This is RenderBox
class RenderCanvasDrawImage extends RenderBox {
  RenderCanvasDrawImage({
    ui.Image? imageFrame,
  }) : _imageFrame = imageFrame;

  ui.Image? get imageFrame => _imageFrame;

  ui.Image? _imageFrame;

  set imageFrame(ui.Image? value) {
    if (_imageFrame == value) {
      return;
    }
    _imageFrame = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    // final desiredWidth = constraints.maxWidth;
    double desiredWidth = constraints.maxWidth;
    double desiredHeight = constraints.maxHeight;
    Size desiredSize = Size(desiredWidth, desiredHeight);
    size = constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    Paint selfPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 30.0;
    if (_imageFrame != null) {
      canvas.drawImage(
          _imageFrame!, Offset(offset.dx + 20, offset.dy + 20), selfPaint);
    }
  }

  // define our variable
  HorizontalDragGestureRecognizer? _drag;

  // Render object can be hit
  @override
  bool hitTestSelf(Offset position) => true;

  // Handle the hit event and send that to our HorizontalDragGestureRecognizer.
  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag?.addPointer(event);
    }
  }

  @override
  void detach() {
    _drag?.dispose();
    super.detach();
  }
}
