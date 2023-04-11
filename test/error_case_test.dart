import 'package:test/test.dart';
import 'package:error_case/error_case.dart';
import 'package:error_case/exception/error_case_exception.dart';

void main() {
  group('ErrorCase', () {
    late ErrorCase errorCase;

    setUp(() {
      errorCase = _MockErrorCase({'key1': 1}, {'key1': 10});
    });

    test('validates a nested key value pair', () {
      final json = {'key1': {'nestedKey1': ''}};
      expect(() => errorCase.validateNestedKeyValue('key1.nestedKey1', json), throwsA(const TypeMatcher<BlankRequiredStringException>()));
    });

    test('validates a null value', () {
      expect(() => errorCase.validateKeyValue('key1', null), throwsA(const TypeMatcher<NullRequiredFieldException>()));
    });

    test('validates a string', () {
      expect(() => errorCase.validateKeyValue('key1', ''), throwsA(const TypeMatcher<BlankRequiredStringException>()));
      expect(() => errorCase.validateKeyValue('key2', 'value'), returnsNormally);
    });

    test('validates a number', () {
      expect(() => errorCase.validateKeyValue('key1', 1), returnsNormally);
      expect(() => errorCase.validateKeyValue('key1', 11), throwsA(const TypeMatcher<ValueAboveMaximumException>()));
      expect(() => errorCase.validateKeyValue('key1', 0), throwsA(const TypeMatcher<ValueBelowMinimumException>()));
    });

    test('validates a map', () {
      expect(() => errorCase.validateKeyValue('key1', {}), throwsA(const TypeMatcher<EmptyRequiredListException>()));
      expect(() => errorCase.validateKeyValue('key2', {'key': 'value'}), returnsNormally);
    });

    test('validates a list', () {
      expect(() => errorCase.validateKeyValue('key1', []), throwsA(const TypeMatcher<EmptyRequiredListException>()));
      expect(() => errorCase.validateKeyValue('key2', ['value']), returnsNormally);
    });
  });
}

class _MockErrorCase extends ErrorCase {
  _MockErrorCase(Map<String, num?> minimumValue, Map<String, num?> maximumValue) : super(minimumValue, maximumValue);
}