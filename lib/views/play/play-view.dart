

import 'dart:ui';


import 'package:flutter/gestures.dart';
import 'package:mciot_game/components/birds/bird.dart';
import 'package:mciot_game/components/birds/lifecycle.dart';
import 'package:mciot_game/components/birds/layers.dart';

import 'package:mciot_game/mciot-game.dart';
import 'package:mciot_game/views/play/high-score-display.dart';

import 'package:mciot_game/views/play/score-display.dart';
import 'package:mciot_game/views/play/update-button.dart';
import 'package:mciot_game/views/view.dart';

class PlayView extends View {

  UpdateButton _updateButton;
  ScoreDisplay _scoreDisplay;
  HighScoreDisplay _highScoreDisplay;

  PlayView(MCIOTGame game) : super(game) {
    _updateButton = new UpdateButton(game);
    _scoreDisplay = new ScoreDisplay(game);
    _highScoreDisplay = new HighScoreDisplay(game);
  }
  @override
  void render(Canvas c) {

    game.map.render(c, 0);
    game.birds.where((Bird b) => b.layer.isBack ).forEach((Bird b) => b.render(c));
    game.map.render(c, 1);
    game.birds.where((Bird b) => b.layer.isFront).forEach((Bird b) => b.render(c));
    game.map.render(c, 2);
    _updateButton.render(c);
    _scoreDisplay.render(c);
    _highScoreDisplay.render(c);
  }

  @override
  void update(double t) {
    if (game.timer <= 0) {
      game.stopGame();
    } else {
      // Background position Update
      game.map.update(t);
      // Birds Update
      game.birds.forEach((Bird b)  => b.update(t));
      game.birds.removeWhere((Bird b) => b.lifecycle == Lifecycle.dead);

     _scoreDisplay.update(t);
    }
  }

  @override
  void onTapDown(TapDownDetails d) {
    if (_updateButton.rectContains(d.globalPosition)) {
      _updateButton.onTapDown();
    }
    game.birds.where((Bird b) => b.rectContains(d.globalPosition))?.forEach((Bird b) => b.onHit());
  }

  @override
  void viewEnter() {
    _highScoreDisplay.update();
  }

  @override
  void viewLeave() {
    // TODO: implement viewLeave
  }



}