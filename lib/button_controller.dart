import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter_my_george_game/main.dart';

class ButtonController extends StatelessWidget {
  final MyGeorgeGame game;
  const ButtonController({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.volume_up_rounded),
        color: Colors.yellow.shade200,
        onPressed: () {
          FlameAudio.bgm.play('smile.mp3');
          print('pressed volume up');
        },
      ),

      IconButton(
        icon: const Icon(Icons.volume_off_rounded),
        color: Colors.yellow.shade200,
        onPressed: () {
          FlameAudio.bgm.stop();
          print('pressed volume off');
        },
      ),
      Text(
        'Some Text',
        style: TextStyle(color: Colors.yellow.shade200, fontSize: 20)
      )
    ]);
  }
}
