import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../common/utils.dart';
import '../widgets/rive_render_widget.dart';

class ShowRivePage extends StatefulWidget {
  const ShowRivePage({Key? key}) : super(key: key);

  @override
  State<ShowRivePage> createState() => _ShowRiveState();
}

class _ShowRiveState extends State<ShowRivePage> {
  TimelineRive? _riveAsset;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAssetRive();
  }

  // //Get local pictures
  // Future<void> _getAssetRive() async {
  //   var actor = await RiveFile.asset('assets/vehicles.riv');
  //   setState(() {
  //     _riveArtBoard = actor.artboards[0];
  //     _riveArtBoard?.artboard.instance();
  //     _riveArtBoard?.artboard.advance(3.0);
  //   });
  // }

  //Get local pictures
  Future<void> _getAssetRive() async {
    TimelineRive riveAsset = TimelineRive();
    var actor = await RiveFile.asset('assets/player.riv');
    // riveAsset.actorStatic = actor.artboards[0];
    // riveAsset.actorStatic.initializeGraphics();
    riveAsset.actor = actor.mainArtboard;
    var controller = StateMachineController.fromArtboard(
      riveAsset.actor,
      'State Machine 1',
    );
    // print(actor.mainArtboard);
    if (controller != null) {
      riveAsset.actor.addController(controller);
    }

    /// riveAsset.idle = riveAsset.actor.animationByName("idle") as
    /// RiveAnimation;
    // riveAsset.animationTime = 0.0;
    riveAsset.actor.advance(1.0);
    // riveAsset.animation.apply(riveAsset.animationTime);
    // riveAsset.actor.advance(1.0);
    // riveAsset.actorStatic.advance(0.0);
    setState(() {
      _riveAsset = riveAsset;
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
        child: CanvasDrawRive(_riveAsset),
      ),
    );
  }
}
