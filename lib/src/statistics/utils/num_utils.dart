/// Utils for numbers.
extension NumUtils on num {
  /// Returns the percentage of this number in relation to [total].
  ///
  /// If the [total] is zero, returns zero.
  double percentageOfOrZero(num total) => total == 0 ? 0 : this / total;
}
