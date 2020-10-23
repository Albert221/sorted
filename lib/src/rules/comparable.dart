import '../rule.dart';
import 'comparator.dart';

class SortedComparable<T, P extends Comparable> extends SortedComparator<T, P> {
  SortedComparable(SortedMapper<T, P> mapper, {bool invert = false})
      : super(mapper, Comparable.compare, invert: invert);
}
