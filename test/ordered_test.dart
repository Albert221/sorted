import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedOrdered', () {
    test('compares enums in order correctly', () {
      const order = [Letters.B, Letters.A, Letters.C];

      const a = Letters.A;
      const b = Letters.B;

      final result =
          SortedOrdered<Letters, Letters>((x) => x, order).compare(a, b);

      expect(result, 1);
    });
  });
}

enum Letters { A, B, C }
