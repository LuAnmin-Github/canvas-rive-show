import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../common/utils.dart';

class CanvasDrawRive extends LeafRenderObjectWidget {
  const CanvasDrawRive(
    this.riveAsset, {
    Key? key,
  }) : super(key: key);

  final TimelineRive? riveAsset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCanvasDrawRive(
      riveAsset: riveAsset,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCanvasDrawRive renderObject) {
    renderObject.riveAsset = riveAsset;
  }
}

/// This is RenderBox
class RenderCanvasDrawRive extends RenderBox {
  RenderCanvasDrawRive({
    TimelineRive? riveAsset,
  }) : _riveAsset = riveAsset;

  TimelineRive? get riveAsset => _riveAsset;

  TimelineRive? _riveAsset;

  set riveAsset(TimelineRive? value) {
    if (_riveAsset == value) {
      return;
    }
    _riveAsset = value;
    markNeedsPaint();
  }

  @override
  void performResize() {
    size = constraints.biggest;
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
    canvas.scale(0.15);
    // artBoard?.draw(canvas);
    print("hello");
    riveAsset?.actor.draw(canvas);
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
