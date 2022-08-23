import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:rive_example/utils.dart';

import '../widgets/image_render_widget.dart';

class ShowImagePage extends StatefulWidget {
  const ShowImagePage({Key? key}) : super(key: key);

  @override
  State<ShowImagePage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImagePage> {
  ui.Image? _assetImageFrame;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAssetImage();
  }

  //Get local pictures
  Future<void> _getAssetImage() async {
    ui.Image imageFrame =
        await getAssetImage('assets/0.png', width: 300, height: 300);
    setState(() {
      _assetImageFrame = imageFrame;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw image by canvas'),
      ),
      body: Center(
        child: CanvasDrawImage(_assetImageFrame),
      ),
    );
  }
}
