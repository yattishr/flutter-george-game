import 'package:basic/play_chicken/play_chicken_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import '../constants.dart';
import 'package:basic/play_chicken/play_chicken_screen.dart';
import 'package:basic/homeMap/homemap_world.dart';

class MyGeorgeGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation idleChickenAnimation;
  late GeorgeComponent player;
  late SpriteAnimationComponent chicken; // Define the chicken component here
  Vector2 movement = Vector2.zero();

  String soundTrackName = 'smiley';

  // Create an instance of HomeMapWorld
  final homeMapWorld = HomeMapWorld();



  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Load the home map world
    await homeMapWorld.onLoad();    

    // Get the world from HomeMapWorld
    final world = homeMapWorld.getWorld();

    // added chicken component here to test collision detection later.
    final playChickenScreen = PlayChickenScreen();
    await playChickenScreen.loadChicken();

    chicken = playChickenScreen.chicken;

    final camera = CameraComponent.withFixedResolution(
      world: world,
      width: gameWidth,
      height: gameHeight,
    );

    // set camera priority.
    camera.priority = 1;

    camera.viewfinder
      ..anchor = Anchor.topLeft
      ..zoom = 2.0;

    // add background audio
    FlameAudio.bgm.initialize();
    FlameAudio.audioCache.load('littleidea.mp3');

    // add button overlay to toggle music.
    overlays.add('ButtonController');

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
    player = GeorgeComponent()
      ..animation = idleAnimation
      ..position = Vector2(100, 200)
      ..size = Vector2.all(characterSize)
      ..priority = 2
      ..debugMode = true
      ..anchor = Anchor.center;

    // add all components.
    addAll([world, camera, player]);

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
        if (player.y < gameHeight - player.height) {
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
        if (player.x < gameWidth - (player.width + 10)) {
          player.x += dt * (characterSpeed - 10);
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

class GeorgeComponent extends SpriteAnimationComponent
    with HasCollisionDetection {
  GeorgeComponent() {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Component> otherComponents) {

      if (otherComponents is ChickenComponent) {
        print("Collision with cluck cluck!");
        // Handle collision logic here
      }
  }
}

class ChickenComponent extends PositionComponent
    with HasCollisionDetection {
  ChickenComponent() {
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Component> otherComponents) {
      if (otherComponents is GeorgeComponent) {
        print("Collision with player!");
        // Handle collision logic here
      }
  }
}