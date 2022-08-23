import 'dart:ui' as ui;

import 'package:flutter/services.dart';

Future<ui.Image> getAssetImage(String asset,
    {int width = 300, int height = 300}) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
