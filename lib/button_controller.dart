import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_my_george_game/game/game_component.dart';

class ButtonController extends StatelessWidget {
  final MyGeorgeGame game;
  ButtonController({Key? key, required this.game}) : super(key: key);
  final TextPaint textPaint =
      TextPaint(style: const TextStyle(color: Colors.white, fontSize: 20));
  final countdown = Timer(2);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black26, // Adjust opacity for desired darkness
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
              "Countdown: ${countdown.current.toString()}",
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

  @override
  void update(double dt) {
    countdown.update(dt);
    if (countdown.finished) {
      // Prefer the timer callback, but this is better in some cases
    }
  }

  @override
  void render(Canvas canvas) {
    textPaint.render(
      canvas,
      "Countdown: ${countdown.current.toString()}",
      Vector2(10, 100),
    );
  }
}
