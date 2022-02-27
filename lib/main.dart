import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'package:flame/components.dart';

class Player extends PositionComponent with HasGameRef<SpaceShooterGame> {
  static final _paint = Paint()..color = Colors.white;
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), _paint);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = gameRef.size / 2;
    width = 100;
    height = 150;
    anchor = Anchor.center;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}

class SpaceShooterGame extends FlameGame with PanDetector {
  late Player player;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    player = Player();
    add(player);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.game);
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}
