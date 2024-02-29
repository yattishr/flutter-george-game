import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'button_controller.dart';
import 'package:flutter_my_george_game/game/game_component.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: GameWidget(
            game: MyGeorgeGame(),
            overlayBuilderMap: {
              'ButtonController': (BuildContext context, MyGeorgeGame game) {
                return ButtonController(game: game);
              }
            },
      ))));
}