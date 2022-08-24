import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

Future<ui.Image> getAssetImage(String asset,
    {int width = 300, int height = 300}) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}

class TimelineAsset {
  late double width;
  late double height;
  double opacity = 0.0;
  double scale = 0.0;
  double scaleVelocity = 0.0;
  double y = 0.0;
  double velocity = 0.0;
}

/// This asset also has information regarding its animations.
class TimelineAnimatedAsset extends TimelineAsset {
  late bool loop;
  double animationTime = 0.0;
  double offset = 0.0;
  double gap = 0.0;
}

/// A `Rive` Asset.
class TimelineRive extends TimelineAnimatedAsset {
  late Artboard actorStatic;
  late Artboard actor;
  late LinearAnimation animation;

  /// Some Flare assets will have multiple idle animations (e.g. 'Humans'),
  /// others will have an intro&idle animation (e.g. 'Sun is Born').
  /// All this information is in `timeline.json` file, and it's de-serialized in the
  /// [Timeline.loadFromBundle()] method, called during startup.
  /// and custom-computed AABB bounds to properly position them in the timeline.
  late LinearAnimationInstance intro;
  late LinearAnimationInstance idle;
  List<RiveAnimation> idleAnimations = [];
}
