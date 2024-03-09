import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class IntroGeorgeGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation idleChickenAnimation;
  late SpriteAnimationComponent player; // Define the chicken component here
  Vector2 movement = Vector2.zero();

  String soundTrackName = 'smiley';

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // add button overlay to toggle music.
    overlays.add('IntroController');

    // player sprite sheet.
    final spriteSheet = SpriteSheet(
      image: await images.load('player.png'),
      srcSize: Vector2(48, 48),
    );

    // sprite animations
    rightAnimation = spriteSheet.createAnimation(row: 3, stepTime: 0.5, to: 4);

    // create sprite animation component
    player = SpriteAnimationComponent()
      ..animation = rightAnimation
      ..position = Vector2(150, 200)
      ..size = Vector2.all(characterSize)
      ..priority = 2
      ..debugMode = true
      ..debugColor = Colors.amber
      ..anchor = Anchor.center;

    // add all components.
    addAll([player]);
  }
}