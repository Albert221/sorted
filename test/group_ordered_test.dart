import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedGroupOrdered', () {
    test('compares items from the same group equal', () {
      const order = [
        [Letters.A, Letters.B],
        [Letters.C],
      ];

      const a = Letters.A;
      const b = Letters.B;

      final result =
          SortedGroupOrdered<Letters, Letters>((x) => x, order).compare(a, b);

      expect(result, 0);
    });

    test('compares items from different groups correctly', () {
      const order = [
        [Letters.A, Letters.B],
        [Letters.C],
      ];

      const c = Letters.C;
      const b = Letters.B;

      final result =
          SortedGroupOrdered<Letters, Letters>((x) => x, order).compare(c, b);

      expect(result, 1);
    });
  });
}

enum Letters { A, B, C }
