import '../rule.dart';
import 'comparator.dart';

/// Sorting rule that uses `Comparable.compare` to compare two items. Considers
/// two `null`s equal and one `null` always lesser than other values.
class SortedComparable<T, P extends Comparable?>
    extends SortedComparator<T, P> {
  SortedComparable(SortedMapper<T, P> mapper, {bool invert = false})
      : super(mapper, (a, b) {
          if (a == null && b == null) return 0;
          if (a == null) return -1;
          if (b == null) return 1;

          return Comparable.compare(a, b);
        }, invert: invert);
}
