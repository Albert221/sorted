import '../rule.dart';

/// Sorting rule that uses a custom `comparator`.
class SortedComparator<T, P> extends SortedRule<T, P> {
  SortedComparator(
    SortedMapper<T, P> mapper,
    this.comparator, {
    bool invert = false,
  })  : assert(comparator != null),
        super(mapper, invert: invert);

  final Comparator<P> comparator;

  @override
  int compare(P a, P b) => comparator(a, b);
}
