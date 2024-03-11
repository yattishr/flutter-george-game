import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayChickenScreen extends FlameGame {
  late SpriteAnimationComponent chicken;
  bool isAnimationPlaying = true;

  @override
  Future<void> loadChicken() async {
    super.onLoad();
    print('load game assets');

    // 1. load the sprite sheet
    final spriteSheet = await images.load('chicken_run.png');
    final spriteSize = Vector2(32, 34);

    // 2. Sprite animationData
    final animationData = SpriteAnimationData.sequenced(
      amount: 14,
      stepTime: 0.1,
      textureSize: spriteSize,
    );

    // 3. Create the animation
    chicken =
        SpriteAnimationComponent.fromFrameData(spriteSheet, animationData)
        ..position = Vector2(150, 200)
        ..size = Vector2(64, 68)
        ..debugMode = true
        ..debugColor = Colors.amber
        ..priority = 2;
    camera.follow(chicken);
  }

  // animate the Sprite to move from Right to Left
  @override
  void update(double dt) {
    if (isAnimationPlaying) {
      // Move the chicken towards the left
      chicken.position.x -= 100 * dt;

      // Check if the chicken is off the left side of the screen
      if (chicken.position.x + chicken.size.x < 0) {
        // Reset the chicken to the right side of the screen
        chicken.position.x = size.x;
      }
      // Call the parent update method
      super.update(dt);
    }
  }

@override
  void onTap() {
    print('Tapped!');
    // Toggle the animation state on tap
    isAnimationPlaying = !isAnimationPlaying;

    // If animation is stopped, reset the chicken position
    if (!isAnimationPlaying) {
      chicken.position = Vector2(size.x - chicken.size.x, 100);
    }
  }
}
