typedef SortedMapper<T, P> = P Function(T);

abstract class SortedRule<T, P> {
  const SortedRule(this.mapper, {this.invert = false})
      : assert(mapper != null),
        assert(invert != null);

  final SortedMapper<T, P> mapper;
  final bool invert;

  int compareComplex(T a, T b) {
    final result = compare(
      mapper(a),
      mapper(b),
    );

    return invert ? -result : result;
  }

  int compare(P a, P b);
}
