import 'dart:math';

import 'package:flame/components.dart';
import 'package:simple_game/componenets/obstacle_component.dart';
import 'package:simple_game/na_catch_game.dart';

import 'globals.dart';

class ObstacleManager extends Component with HasGameRef<NaCatchGame> {
  late Timer _timer;
  Random random = Random();

  ObstacleManager() : super() {
    _timer = Timer(
      .5,
      onTick: _spawnObstacle,
      repeat: true,
    );
  }

  void _spawnObstacle() {
    final List<String> obstaclesRight = [
      Globals.rightOne,
      Globals.rightTwo,
      Globals.rightThree,
      Globals.rightFour,
    ];

    final List<String> obstaclesWrong = [
      Globals.wrongOne,
      Globals.wrongTwo,
      Globals.wrongThree,
      Globals.wrongFour,
    ];
    final intialSize = Vector2(94, 104);
    final int typeVal = random.nextInt(2);
    final bool isType = (typeVal == 1 ? true : false);

    final String imgPath = (typeVal == 1)
        ? obstaclesRight[(random.nextInt(3))]
        : obstaclesWrong[(random.nextInt(3))];

    final Vector2 position = Vector2(random.nextDouble() * gameRef.size.x, 0);
    position.clamp(
        Vector2.zero() + intialSize / 2, gameRef.size - intialSize / 2);

    Obstacle obstacle = Obstacle(
      postionC: position,
      spSize: intialSize,
      type: isType,
      spritePath: imgPath,
    );

    add(
      obstacle,
    );
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void onRemove() {
    super.onRemove();
    _timer.stop();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
