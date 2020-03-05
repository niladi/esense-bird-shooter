import 'package:flame/sprite.dart';
import 'package:mciot_game/components/birds/bird.dart';
import 'package:mciot_game/components/birds/layers.dart';
import 'package:mciot_game/components/direction.dart';
import 'package:mciot_game/components/moving-component.dart';
import 'package:mciot_game/mciot-game.dart';

class MonsterBird extends Bird {

  static const String NAME = 'monster';

  MonsterBird(MCIOTGame game, Direction direction, double speed, Layers layer)
      : super(game , direction, speed, layer, 1 ,game.tileSize * 1.15);

  @override
  List<Sprite> get initMoves => movesLoader(4, NAME);

  @override
  Sprite get initDying => dyingLoader(NAME);

  static List<String> get pictures => MovingComponent.pictures(4, NAME);

}