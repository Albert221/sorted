import 'rule.dart';

extension Sorted<T> on Iterable<T> {
  /// Returns a sorted list according to the `rules`. Order matters, so if
  /// first rule considers two items equal, next one will decide and so on.
  List<T> sorted(List<SortedRule> rules) {
    if (rules.isEmpty) return List.of(this);

    return List.of(this)
      ..sort((a, b) {
        int result = 0;
        for (final rule in rules) {
          result = rule.compareComplex(a, b);

          if (result != 0) return result;
        }

        return result;
      });
  }
}
