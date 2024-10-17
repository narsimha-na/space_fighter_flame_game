import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:simple_game/componenets/obstacle_component.dart';
import 'package:simple_game/contants/globals.dart';
import 'package:simple_game/na_catch_game.dart';

class PlaceholderComponenet extends SpriteComponent
    with HasGameRef<NaCatchGame>, CollisionCallbacks {
  final double placeHolderHeight = 110.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.placeHolder);
    position = Vector2(gameRef.size.x / 2, gameRef.size.y);
    width = placeHolderHeight;
    height = placeHolderHeight;
    anchor = Anchor.bottomCenter;
    add(CircleHitbox());
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollision(intersectionPoints, other);
  //   if (other is Obstacle) {
  //     remove(other);
  //   }
  // }

  void move(double deltaX) {
    double newX = position.x + deltaX;

    double minX = -(gameRef.size.x / 2) + 260; // Left boundary
    double maxX = (gameRef.size.x) - 60; // Right boundary
    newX = newX.clamp(minX, maxX);

    position.x = newX;
  }
}
