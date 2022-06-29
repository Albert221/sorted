import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('DefaultSortingStrategy', () {
    test('sorts the list in-place', () {
      final list = [1, 3, 2, 1];

      const DefaultSortingStrategy<int>().sort(list, (a, b) => a - b);

      expect(list, [1, 1, 2, 3]);
    });
  });
}
