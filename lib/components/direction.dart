import 'dart:math';

enum Direction {
  left, right
}

extension DirectionExtention on Direction {
  static Direction leftByBoolean(bool value) {
    return value ? Direction.left : Direction.right;
  }

  static Direction random(Random rnd) {
    return DirectionExtention.leftByBoolean(rnd.nextBool());
  }

  bool get isLeft => this == Direction.left ? true : false;

  String get fileShort => this.isLeft ? 'l' : 'r';
}

extension BirdExtention on Direction {

  double moveX(double value) {
    return this.isLeft ? value * (-1) : value;
  }

}