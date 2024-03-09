import 'package:basic/play_chicken/play_chicken_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
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
    downAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.5, to: 4);
    leftAnimation = spriteSheet.createAnimation(row: 1, stepTime: 0.5, to: 4);
    upAnimation = spriteSheet.createAnimation(row: 2, stepTime: 0.5, to: 4);
    rightAnimation = spriteSheet.createAnimation(row: 3, stepTime: 0.5, to: 4);
    idleAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.5, to: 1);

    // create sprite animation component
    player = SpriteAnimationComponent()
      ..animation = rightAnimation
      ..position = Vector2(150, 350)
      ..size = Vector2.all(characterSize)
      ..priority = 2
      ..debugMode = true
      ..anchor = Anchor.center;

    // add all components.
    addAll([player]);
  }
}