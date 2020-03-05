import 'dart:math';

enum Layers{
  front, back
}
extension LayersExtention on Layers {
  bool get isFront => this == Layers.front;
  bool get isBack => this == Layers.back;

  static Layers frontByBoolean(bool value) {
    return value ? Layers.front : Layers.back;
  }

  static Layers random(Random rnd) {
    return LayersExtention.frontByBoolean(rnd.nextBool());
  }
}
extension BirdExtention on Layers {
  double get sizeMultiplier => this.isFront ? 1.25 : 0.75;

  int scoreAmmount (int amount) => this.isFront ? amount : 2 * amount;

}