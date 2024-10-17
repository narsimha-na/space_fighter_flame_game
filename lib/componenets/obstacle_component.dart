import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:simple_game/componenets/placeholder_componenet.dart';
import 'package:simple_game/na_catch_game.dart';

import '../contants/globals.dart';

class Obstacle extends SpriteComponent
    with HasGameRef<NaCatchGame>, CollisionCallbacks {
  String spritePath;
  Vector2 postionC;
  Vector2 spSize;
  bool type;
  double _speed = 10;

  Obstacle({
    required this.postionC,
    required this.spSize,
    required this.type,
    required this.spritePath,
  });

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(spritePath);
    size = spSize;
    position = postionC;
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += 200 * dt;

    if (position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is PlaceholderComponenet) {
      removeFromParent();
    }
  }
}
