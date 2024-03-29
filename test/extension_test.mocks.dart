// Mocks generated by Mockito 5.2.0 from annotations
// in sorted/test/extension_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:sorted/src/rule.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [SortedRule].
///
/// See the documentation for Mockito's code generation for more information.
class MockRule extends _i1.Mock implements _i2.SortedRule<String, String> {
  MockRule() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SortedMapper<String, String> get mapper => (super.noSuchMethod(
      Invocation.getter(#mapper),
      returnValue: (String __p0) => '') as _i2.SortedMapper<String, String>);
  @override
  bool get invert =>
      (super.noSuchMethod(Invocation.getter(#invert), returnValue: false)
          as bool);
  @override
  int compareComplex(String? a, String? b) =>
      (super.noSuchMethod(Invocation.method(#compareComplex, [a, b]),
          returnValue: 0) as int);
  @override
  int compare(String? a, String? b) =>
      (super.noSuchMethod(Invocation.method(#compare, [a, b]), returnValue: 0)
          as int);
}
