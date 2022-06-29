import 'package:collection/collection.dart';

import '../sorting_strategy.dart';

/// A [SortingStrategy] which uses merge sort, a stable sorting algorithm.
class MergeSortingStrategy<T> implements SortingStrategy<T> {
  const MergeSortingStrategy();

  @override
  void sort(List<T> list, Comparator<T> comparator) {
    mergeSort(list, compare: comparator);
  }
}
