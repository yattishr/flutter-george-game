// import 'package:flame/camera.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'button_controller.dart';
import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
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

class MyGeorgeGame extends FlameGame
    with TapDetector, HasCollisionDetection, KeyboardHandler {
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimationComponent player;
  late double mapWidth;
  late double mapHeight;
  Vector2 movement = Vector2.zero();
  
  String soundTrackName = 'smiley';

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // define home map
    final homeMap = await TiledComponent.load('map.tmx', Vector2.all(16));

    // define the world
    final world = World(children: [homeMap]);

    // experimenting with the variables below:
    Vector2 movement = Vector2.zero();

    mapWidth = homeMap.tileMap.map.width * 16.0;
    mapHeight = homeMap.tileMap.map.height * 16.0;

    print(mapWidth);
    print(mapHeight);

    final camera = CameraComponent.withFixedResolution(
      world: world, width: 160, height: 320);  
    
    camera.priority = 1;

    // Move the camera to center of the map
    camera.moveTo(Vector2(mapWidth * 0.5, mapHeight * 0.5));

    // add background audio
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('smile.mp3');

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
      ..size = Vector2.all(characterSize)
      ..priority = 2
      ..debugMode = true
      ..anchor = Anchor.center;

    // add all components.
    addAll([camera, world, player]);

    // camera set up.
    camera.follow(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // direction:  0 = idle, 1 = down, 2 = left, 3 = up, 4 = right
    switch (direction) {
      case 0:
        player.animation = idleAnimation;
        break;
      case 1:
        player.animation = downAnimation;
        if (player.y < mapHeight - player.height) {
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
        if (player.x < mapWidth - player.width) {
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
    print('direction is: $direction');

    // check if direction exceeds 4, reset direction to zero.
    if (direction > 4) {
      direction = 0;
    }
  }
}