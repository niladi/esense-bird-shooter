import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:mciot_game/mciot-game.dart';


class EsenseStatusDisplay {
  final MCIOTGame _game;
  TextPainter _painter;
  TextStyle _textStyle;
  Offset _position;

  EsenseStatusDisplay(this._game) {
    _painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    _textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      shadows: <Shadow>[shadow, shadow, shadow, shadow],
    );

    _position = Offset.zero;

    update();
  }

  void update() {
    _painter.text = TextSpan(
      text: 'Esense Status: ' + _game.esenseState.toString(),
      style: _textStyle,
    );

    _painter.layout();

    _position = Offset(
      _game.screenWidth / 2 - _painter.width/2,
      _game.screenHeight / 2 - 1.5 * _game.tileSize,
    );
  }

  void render(Canvas c) {
    _painter.paint(c, _position);
  }
}