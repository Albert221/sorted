import '../rule.dart';

class SortedGroupOrdered<T, P> extends SortedRule<T, P> {
  SortedGroupOrdered(
    SortedMapper<T, P> mapper,
    this.orderGroups, {
    bool invert = false,
  })  : assert(orderGroups != null),
        assert(orderGroups.every((group) => group != null)),
        assert(
          () {
            final flat = orderGroups.expand((x) => x);
            return flat.toList().length == flat.toSet().length;
          }(),
          "all items in orderGroups's groups must be unique",
        ),
        super(mapper, invert: invert);

  final List<List<P>> orderGroups;

  @override
  int compare(P a, P b) {
    final aIndex = _findGroupIndex(a);
    if (aIndex == -1) {
      throw StateError(
        'Cannot sort value "$a". Add it to the orderGroups list first.',
      );
    }

    final bIndex = _findGroupIndex(b);
    if (bIndex == -1) {
      throw StateError(
        'Cannot sort value "$b". Add it to the orderGroups list first.',
      );
    }

    return aIndex.compareTo(bIndex);
  }

  int _findGroupIndex(P item) {
    int index = 0;
    for (final group in orderGroups) {
      if (group.contains(item)) return index;

      index++;
    }

    return -1;
  }
}
