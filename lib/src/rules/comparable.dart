import '../rule.dart';

class SortedComparable<T, P extends Comparable> extends SortedRule<T, P> {
  const SortedComparable(SortedMapper<T, P> mapper, {bool invert = false})
      : super(mapper, invert: invert);

  @override
  int compare(P a, P b) => Comparable.compare(a, b);
}
