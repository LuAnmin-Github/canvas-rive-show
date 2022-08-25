import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleAnimation extends StatelessWidget {
  const SimpleAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const riveAnimation = RiveAnimation.asset(
      'assets/parallax.riv',
      fit: BoxFit.cover,
      animations: ["orbitAnimation"],
    );

    print(riveAnimation.animations);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Animation'),
      ),
      body: const Center(
        child: riveAnimation,
      ),
    );
  }
}
