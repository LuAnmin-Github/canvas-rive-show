import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via one numeric input.
class StateMachineSkills extends StatefulWidget {
  const StateMachineSkills({Key? key}) : super(key: key);

  @override
  _StateMachineSkillsState createState() => _StateMachineSkillsState();
}

class _StateMachineSkillsState extends State<StateMachineSkills> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtBoard;
  StateMachineController? _controller;
  SMIInput<double>? _levelInput;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/skills.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artBoard is the root of the animation and gets drawn in the
        // Rive widget.
        final artBoard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artBoard, 'Designer\'s Test');
        if (controller != null) {
          artBoard.addController(controller);
          _levelInput = controller.findInput('Level');
        }
        setState(() => _riveArtBoard = artBoard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Skills Machine'),
      ),
      body: Center(
        child: _riveArtBoard == null
            ? const SizedBox()
            : Stack(
                children: [
                  Positioned.fill(
                    child: Rive(
                      artboard: _riveArtBoard!,
                    ),
                  ),
                  Positioned.fill(
                    bottom: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: const Text('Beginner'),
                          onPressed: () => _levelInput?.value = 0,
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Intermediate'),
                          onPressed: () => _levelInput?.value = 1,
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          child: const Text('Expert'),
                          onPressed: () => _levelInput?.value = 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
