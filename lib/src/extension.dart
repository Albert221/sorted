import 'rule.dart';

extension Sorted<T> on List<T> {
  List<T> sorted(List<SortedRule> rules) {
    return this
      ..sort((a, b) {
        int result;
        for (final rule in rules) {
          result = rule.compareComplex(a, b);

          if (result != 0) return result;
        }

        return result;
      });
  }
}
