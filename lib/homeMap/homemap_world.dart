import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class HomeMapWorld extends FlameGame with HasGameReference {
  late World world; // Declare world variable

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Define home map
    final homeMap = await TiledComponent.load('map.tmx', Vector2.all(16));

    // Define the world
    world = World(children: [homeMap]);
  }

  // Getter method to access the world
  World getWorld() {
    return world;
  }
}