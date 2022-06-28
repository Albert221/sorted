import 'package:sorted/src/sorting_strategy.dart';

/// A [SortingStrategy] which uses dart's default (unstable) sorting method
class DefaultSortingStrategy<T> implements SortingStrategy<T> {
  const DefaultSortingStrategy();

  @override
  void sort(List<T> list, Comparator<T> comparator) {
    list.sort(comparator);
  }
}
