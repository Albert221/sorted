import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

import 'extension_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<SortedRule<String, String>>(as: #MockRule),
])
void main() {
  group('SortedExtension', () {
    test('returns list with the same items with no rules', () {
      final list = ['foo', 'bar', 'baz'];

      final result = list.sorted([]);

      expect(result, ['foo', 'bar', 'baz']);

      // Make sure it's not the same list so we won't mutate
      // the original at some point after sorted().
      expect(identical(list, result), false);
    });

    test('correctly sorts using one rule', () {
      final rule1 = MockRule();
      when(rule1.compareComplex(any, any)).thenAnswer((invocation) {
        final a = invocation.positionalArguments[0] as String;
        final b = invocation.positionalArguments[1] as String;
        return -a.compareTo(b);
      });

      final list = ['foo', 'bar', 'baz'];

      final result = list.sorted([rule1]);

      expect(result, ['foo', 'baz', 'bar']);

      // Make sure the original list wasn't mutated.
      expect(list, ['foo', 'bar', 'baz']);
    });

    test('correctly sorts using two rules', () {
      final rule1 = MockRule();
      when(rule1.compareComplex(any, any)).thenAnswer((invocation) {
        final a = invocation.positionalArguments[0] as String;
        final b = invocation.positionalArguments[1] as String;
        return a.compareTo(b);
      });
      final rule2 = MockRule();
      when(rule2.compareComplex(any, any)).thenReturn(0);

      final list = ['foo', 'bar', 'baz'];

      final result = list.sorted([rule1, rule2]);

      expect(result, ['bar', 'baz', 'foo']);
    });
  });
}
