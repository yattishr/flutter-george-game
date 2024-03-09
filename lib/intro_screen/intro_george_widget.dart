import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'intro_george_screen.dart';
import 'intro_controller.dart';

class IntroGeorgeWidget extends StatelessWidget {
  const IntroGeorgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
        game: IntroGeorgeGame(),
        loadingBuilder: (_) => Center(child: Text('Loading')),
        // overlayBuilderMap: {
        //   'IntroController': (BuildContext context, IntroGeorgeGame game) {
        //     return Text('Hello George!!!');
        //   },
        // }
        overlayBuilderMap: {
          'IntroController': (BuildContext context, IntroGeorgeGame game) {
            return IntroController(game: game);
          },
        }

        );
  }
}
