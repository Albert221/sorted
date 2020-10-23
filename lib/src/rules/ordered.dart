import '../rule.dart';

/// Sorting rule that sorts items in the same order as the values in [order]
/// are present.
class SortedOrdered<T, P> extends SortedRule<T, P> {
  SortedOrdered(SortedMapper<T, P> mapper, this.order, {bool invert = false})
      : assert(order != null),
        assert(
          order.length == order.toSet().length,
          'order must contain only unique items',
        ),
        super(mapper, invert: invert);

  final List<P> order;

  @override
  int compare(P a, P b) {
    final aIndex = order.indexOf(a);
    if (aIndex == -1) {
      throw StateError(
        'Cannot sort value "$a". Add it to the order list first.',
      );
    }

    final bIndex = order.indexOf(b);
    if (bIndex == -1) {
      throw StateError(
        'Cannot sort value "$b". Add it to the order list first.',
      );
    }

    return aIndex.compareTo(bIndex);
  }
}
