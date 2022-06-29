import 'sorting_strategies/default.dart';
import 'sorting_strategies/merge.dart';

/// Strategy performing the final sorting procedure given a list and a single comparator.
///
/// See also:
///
///  * [DefaultSortingStrategy], which uses Dart's default (unstable) sorting method.
///  * [MergeSortingStrategy], which uses merge sort, a stable sorting algorithm.
abstract class SortingStrategy<T> {
  /// Sorts [list] in place given a [comparator]
  void sort(List<T> list, Comparator<T> comparator);
}
