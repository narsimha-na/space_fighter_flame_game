import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:simple_game/na_catch_game.dart';

void main() {
  final NaCatchGame game = NaCatchGame();
  runApp(GameWidget(game: game));
}
