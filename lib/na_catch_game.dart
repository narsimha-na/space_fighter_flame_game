import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_game/componenets/background_component.dart';
import 'package:simple_game/componenets/obstacle_component.dart';
import 'package:simple_game/componenets/placeholder_componenet.dart';
import 'package:simple_game/contants/globals.dart';
import 'package:simple_game/contants/obstacle_manager.dart';

class NaCatchGame extends FlameGame
    with HasCollisionDetection, HorizontalDragDetector, KeyboardEvents {
  PlaceholderComponenet placeHolder = PlaceholderComponenet();
  double totalScore = 0.0;

  late Timer _timer;
  int _remainingTime = 30;
  late TextComponent _scoreText;
  late TextComponent _timerText;

  NaCatchGame() : super();
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (_remainingTime == 0) {
          pauseEngine();
        } else {
          _remainingTime -= 1;
        }
      },
    );

    add(BackgroundComponent());
    // add(Obstacle(
    //     postionC: Vector2(150, 200),
    //     spSize: Vector2(2, 2),
    //     type: true,
    //     spritePath: Globals.rightOne));
    loadObstacles();
    add(placeHolder);

    _scoreText = TextComponent(
      text: 'Score: 00',
      position: Vector2(40, 40),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 50),
      ),
    );

    add(_scoreText);

    _timerText = TextComponent(
      text: 'Time: 00:00',
      position: Vector2(size.x - 40, 40),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 50),
      ),
    );

    add(_timerText);

    _timer.start();
  }

  void loadObstacles() {
    add(ObstacleManager());
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    super.onHorizontalDragUpdate(info);
    placeHolder.move(info.delta.global.x);
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const double moveSpeed = 55.0;

    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        placeHolder.move(moveSpeed);
        return KeyEventResult.handled;
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        placeHolder.move(-moveSpeed);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);
    _scoreText.text = 'Score: $totalScore';
    _timerText.text = 'Time: $_remainingTime secs';
  }

  addScore({required double value}) => totalScore += value;
  subractScore({required double value}) => totalScore -= value;
}
