import 'rule.dart';
import 'sorting_strategies/default.dart';
import 'sorting_strategies/merge.dart';
import 'sorting_strategy.dart';

extension Sorted<T> on Iterable<T> {
  /// Returns a sorted list according to the `rules`. Order matters, so if
  /// first rule considers two items equal, next one will decide and so on.
  ///
  /// A sorting strategy can be provided through `sortingStrategy` which
  /// will perform the final sorting procedure. Defaults to [DefaultSortingStrategy].
  /// Consider using [MergeSortingStrategy] if a stable sort is needed.
  List<T> sorted(
    List<SortedRule<T, dynamic>> rules, {
    SortingStrategy<T>? sortingStrategy,
  }) {
    sortingStrategy ??= DefaultSortingStrategy<T>();

    final list = List.of(this);

    if (rules.isEmpty) return list;

    sortingStrategy.sort(list, (a, b) {
      int result = 0;
      for (final rule in rules) {
        result = rule.compareComplex(a, b);

        if (result != 0) return result;
      }

      return result;
    });

    return list;
  }
}
