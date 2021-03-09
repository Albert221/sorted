import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedComparable', () {
    final comparable = SortedComparable<String?, String?>((x) => x);

    test('null is equal to null', () {
      final result = comparable.compare(null, null);

      expect(result, 0);
    });

    test('null is always less than not null', () {
      var result = comparable.compare('a', null);

      expect(result, 1);

      result = comparable.compare(null, 'a');

      expect(result, -1);
    });
  });
}
