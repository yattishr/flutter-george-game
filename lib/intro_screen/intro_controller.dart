import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:basic/play_george/play_george_screen.dart';
import 'intro_george_screen.dart';

class IntroController extends StatelessWidget {
  final IntroGeorgeGame game;
  IntroController({Key? key, required this.game}) : super(key: key);

  final TextPaint textPaint =
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 20));
  final countdown = Timer(2);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white60, // Adjust opacity for desired darkness
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Add spacing
          children: [
            IconButton(
              iconSize: 40, // Larger icon size
              color: Colors.yellow.shade200, // Light color for contrast
              icon: const Icon(Icons.volume_up_rounded),
              onPressed: () {
                FlameAudio.bgm.play('littleidea.mp3');
                print('pressed volume up');
              },
            ),
            IconButton(
              iconSize: 40, // Larger icon size
              color: Colors.yellow.shade200, // Light color for contrast
              icon: const Icon(Icons.volume_off_rounded),
              onPressed: () {
                FlameAudio.bgm.stop();
                print('pressed volume off');
              },
            ),
            Text(
              "Score: ${countdown.current.toString()}",
              style: TextStyle(
                color: Colors.yellow.shade200,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
