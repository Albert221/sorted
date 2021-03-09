typedef SortedMapper<T, P> = P Function(T);

/// A rule describing how to compare two properties.
abstract class SortedRule<T, P> {
  const SortedRule(this.mapper, {this.invert = false});

  /// Function mapping an object to the desired property (or itself).
  final SortedMapper<T, P> mapper;

  /// Whether to invert the sorting order.
  final bool invert;

  /// Compare two `T` objects.
  int compareComplex(T a, T b) {
    final result = compare(
      mapper(a),
      mapper(b),
    );

    return invert ? -result : result;
  }

  /// Compare two `P` properties returned by the [mapper].
  int compare(P a, P b);
}
