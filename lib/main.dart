import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'button_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
          home:
          Scaffold(
              body: GameWidget(
                game: MyGeorgeGame(),
                overlayBuilderMap: {
                  'ButtonController': (BuildContext context, MyGeorgeGame game) {
                    return ButtonController(game: game);
                  }
                },
              )
          )
      )
  );
}

class MyGeorgeGame extends FlameGame with TapDetector {
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimationComponent george;
  late SpriteAnimationComponent player;
  late SpriteComponent background;

  // 0 = idle, 1 = down, 2 = left
  int direction = 0;
  final double animationSpeed = 0.1;
  final double characterSize = 100;
  final double worldCoordinates = 0.1;
  final double characterSpeed = 80;
  String soundTrackName = 'smiley';

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // load background
    Sprite backgroundSprite = await loadSprite('background.png');
    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size=backgroundSprite.originalSize;
    add(background);

    // add background audio
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('music.mp3');

    // add button overlay to toggle music.
    overlays.add('ButtonController');

    final spriteSheet = SpriteSheet(
        image: await images.load('player.png'), srcSize: Vector2(48, 48));

    // sprite animations
    downAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.5, to: 4);
    leftAnimation = spriteSheet.createAnimation(row: 1, stepTime: 0.5, to: 4);
    upAnimation = spriteSheet.createAnimation(row: 2, stepTime: 0.5, to: 4);
    rightAnimation = spriteSheet.createAnimation(row: 3, stepTime: 0.5, to: 4);
    idleAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.5, to: 1);

    // create sprite animation component
    player = SpriteAnimationComponent()
      ..animation = idleAnimation
      ..position = Vector2(100, 200)
      ..size = Vector2.all(characterSize);

    // add player sprite :-)
    add(player);

    // camera set up.
    camera.follow(player);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch(direction) {
      case 0:
        player.animation = idleAnimation;
        break;
      case 1:
        player.animation = downAnimation;
        if (player.y < background.size.y - player.height) {
          player.y += dt * characterSpeed;
        }        
        break;
      case 2:
        player.animation = leftAnimation;
        if (player.x > 0) {
          player.x -= dt * characterSpeed;
        }        
        break;
      case 3:
        player.animation = upAnimation;
        if (player.y > 0) {
          player.y -= dt * characterSpeed;
        }        
        break;
      case 4:
        player.animation = rightAnimation;
        if(player.x < background.size.x - player.width) {
          player.x += dt * characterSpeed;
        }        
        break;
      default:
        player.animation = idleAnimation;
    }
  }

  @override
  void onTapUp(TapUpInfo info) {
    print('Tap event detected');
    direction += 1;

    // check if direction exceeds 4, reset direction to zero.
    if (direction > 4) {
      direction = 0;
    }
  }
}
