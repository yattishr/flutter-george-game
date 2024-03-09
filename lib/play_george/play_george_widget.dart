import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'play_george_screen.dart';
import 'package:basic/play_george/button_controller.dart';

class PlayGeorgeWidget extends StatelessWidget {
  const PlayGeorgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
        game: MyGeorgeGame(),
        loadingBuilder: (_) => Center(child: Text('Loading')),
        overlayBuilderMap: {
          'ButtonController': (BuildContext context, MyGeorgeGame game) {
            return ButtonController(game: game);
          },
        });
  }
}
