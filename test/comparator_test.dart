import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedComparator', () {
    test('compares using string length comparator correctly', () {
      const a = 'lengthy';
      const b = 'sh';

      final result = SortedComparator<String, String>(
        (x) => x,
        (a, b) => a.length.compareTo(b.length),
      ).compare(a, b);

      expect(result, 1);
    });
  });
}
