// import 'package:flame/camera.dart';
import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame_tiled/flame_tiled.dart';
import '../constants.dart';
import '../game/game_component.dart';

class FriendComponent extends PositionComponent with HasCollisionDetection, HasGameReference<MyGeorgeGame> {
  FriendComponent() {
    add(RectangleHitbox());
    void onCollisionStart() {
      print('Collision detected!');      
    }
  }
}