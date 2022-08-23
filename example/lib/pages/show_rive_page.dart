import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../widgets/rive_render_widget.dart';

class ShowRivePage extends StatefulWidget {
  const ShowRivePage({Key? key}) : super(key: key);

  @override
  State<ShowRivePage> createState() => _ShowRiveState();
}

class _ShowRiveState extends State<ShowRivePage> {
  Artboard? _riveArtBoard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAssetRive();
  }

  //Get local pictures
  Future<void> _getAssetRive() async {
    var actor = await RiveFile.asset('assets/windy-tree.riv');
    setState(() {
      _riveArtBoard = actor.artboards[0];
      _riveArtBoard?.artboard.instance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw rive by canvas'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: CanvasDrawRive(_riveArtBoard),
      ),
    );
  }
}
