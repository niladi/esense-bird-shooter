
enum Lifecycle {
  dead, dying, alive
}

extension LifecycleExtention on Lifecycle {
  bool get isDying => this == Lifecycle.dying;

  double moveY(double value) {
    return isDying ? value : 0;
  }
}