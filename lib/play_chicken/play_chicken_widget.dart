import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'play_chicken_screen.dart';

class PlayChickenWidget extends StatelessWidget {
const PlayChickenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: PlayChickenScreen(),
      loadingBuilder: (_) => Center(child: Text('Loading')),
    );
  }
}