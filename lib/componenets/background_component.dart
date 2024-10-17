import 'package:flame/components.dart';
import 'package:simple_game/contants/globals.dart';
import 'package:simple_game/na_catch_game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<NaCatchGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.bgImg);
    size = gameRef.size;
  }
}
