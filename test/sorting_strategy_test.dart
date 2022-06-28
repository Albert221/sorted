import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortingStrategy', () {
    group('DefaultSortingStrategy', () {
      test('sorts the list in-place', () {
        final list = [1, 3, 2, 1];

        const DefaultSortingStrategy<int>().sort(list, (a, b) => a - b);

        expect(list, [1, 1, 2, 3]);
      });
    });

    group('MergeSortingStrategy', () {
      test('sorts the list in-place', () {
        final list = [1, 3, 2, 1];

        const MergeSortingStrategy<int>().sort(list, (a, b) => a - b);

        expect(list, [1, 1, 2, 3]);
      });

      test('sort is stable', () {
        final list = [
          {'prop1': 1, 'prop2': 0},
          {'prop1': 3, 'prop2': 0},
          {'prop1': 1, 'prop2': 1},
          {'prop1': 1, 'prop2': 2},
          {'prop1': 2, 'prop2': 0},
          {'prop1': 1, 'prop2': 1},
        ];

        const MergeSortingStrategy<Map<String, int>>()
            .sort(list, (a, b) => a['prop1']! - b['prop1']!);

        expect(list, [
          {'prop1': 1, 'prop2': 0},
          {'prop1': 1, 'prop2': 1},
          {'prop1': 1, 'prop2': 2},
          {'prop1': 1, 'prop2': 1},
          {'prop1': 2, 'prop2': 0},
          {'prop1': 3, 'prop2': 0},
        ]);
      });
    });
  });
}
