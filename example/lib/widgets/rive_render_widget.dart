import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rive/rive.dart';

class CanvasDrawRive extends LeafRenderObjectWidget {
  const CanvasDrawRive(
    this.artBoard, {
    Key? key,
  }) : super(key: key);

  final Artboard? artBoard;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCanvasDrawRive(
      artBoard: artBoard,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCanvasDrawRive renderObject) {
    renderObject.artBoard = artBoard;
  }
}

/// This is RenderBox
class RenderCanvasDrawRive extends RenderBox {
  RenderCanvasDrawRive({
    Artboard? artBoard,
  }) : _artBoard = artBoard;

  Artboard? get artBoard => _artBoard;

  Artboard? _artBoard;

  set artBoard(Artboard? value) {
    if (_artBoard == value) {
      return;
    }
    _artBoard = value;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    double desiredWidth = constraints.maxWidth;
    double desiredHeight = constraints.maxHeight;
    Size desiredSize = Size(desiredWidth, desiredHeight);
    size = constraints.constrain(desiredSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(50, 200);
    canvas.scale(0.5);
    // artBoard?.draw(canvas);
    artBoard?.artboard.draw(canvas);
    canvas.restore();
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
