import '../rule.dart';
import 'comparator.dart';

class SortedComparable<T, P extends Comparable> extends SortedComparator<T, P> {
  SortedComparable(SortedMapper<T, P> mapper, {bool invert = false})
      : super(mapper, (a, b) {
          if (a == null && b == null) return 0;
          if (a == null) return -1;
          if (b == null) return 1;
          return Comparable.compare(a, b);
        }, invert: invert);
}
