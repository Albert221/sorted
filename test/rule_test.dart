import 'package:mockito/mockito.dart';
import 'package:sorted/sorted.dart';
import 'package:test/test.dart';

void main() {
  group('SortedRule', () {
    test('compareComplex calls compare with mapped object', () {
      final rule = Rule((x) => 'test$x');
      when(rule.compare('testa', 'testb')).thenReturn(1);

      rule.compareComplex('a', 'b');

      verify(rule.compare('testa', 'testb')).called(1);
    });
  });
}

class Rule extends SortedRule<String, String> with Mock {
  Rule(SortedMapper<String, String> mapper) : super(mapper);

  @override
  int compare(String? a, String? b) =>
      super.noSuchMethod(Invocation.method(#compare, [a, b]), returnValue: 0)
          as int;
}
