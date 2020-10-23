import 'package:mockito/mockito.dart';
import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedRule', () {
    test('compareComplex calls compare with mapped object', () {
      final rule = Rule((x) => 'test$x');

      rule.compareComplex('a', 'b');

      verify(rule.compare('testa', 'testb')).called(1);
    });
  });
}

class Rule extends SortedRule with Mock {
  Rule(SortedMapper mapper) : super(mapper);
}
