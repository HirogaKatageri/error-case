import 'package:error_case/error_case.dart';
import 'package:test/test.dart';
import 'package:error_case/exception/error_case_exception.dart';

void main() {
  group('ObjectSingleErrorCase', () {
    late ObjectSingleErrorCase objectSingleErrorCase;

    setUp(() {
      objectSingleErrorCase = _MockObjectSingleErrorCase(['key1']);
    });

    test('validates all required fields successfully', () {
      var value = _MockModel({'key1': 'value', 'key2': 1});
      objectSingleErrorCase.validate(
        value,
        ((exception) {
          fail('should not throw exception');
        }),
        expectAsync1((value) {
          expect(value, equals(value));
        }),
      );
    });

    test('validates a nested required field successfully', () {
      var value = _MockModel({
        'key1': {'nestedKey1': 'value'},
      });
      objectSingleErrorCase.validate(
        value,
        ((exception) {
          fail('should not throw exception');
        }),
        expectAsync1((value) {
          expect(value, equals(value));
        }),
      );
    });

    test('throws NoRequiredFieldsError when no fields are required', () {
      var value = _MockModel({'key1': 'value', 'key2': 1});
      objectSingleErrorCase = _MockObjectSingleErrorCase([]);

      expect(
        () {
          objectSingleErrorCase.validate(
            value,
            ((exception) {
              fail('should throw exception');
            }),
            ((value) {
              fail('should throw exception');
            }),
          );
        },
        throwsA(const TypeMatcher<NoRequiredFieldsError>()),
      );
    });

    test('throws an exception when a required field is missing', () {
      var value = _MockModel({'key2': 1});
      objectSingleErrorCase.validate(
        value,
        expectAsync1((exception) {
          expect(exception, const TypeMatcher<NullRequiredFieldException>());
        }),
        ((value) {
          fail('should throw exception');
        }),
      );
    });
  });
}

class _MockObjectSingleErrorCase extends ObjectSingleErrorCase {
  _MockObjectSingleErrorCase(
    List<String> requiredFields, {
    Map<String, num?> minimumValue = const {},
    Map<String, num?> maximumValue = const {},
  }) : super(
          requiredFields: requiredFields,
          minimumValue: minimumValue,
          maximumValue: maximumValue,
        );
}

class _MockModel extends JsonModel {
  _MockModel(this.json);
  final Map<String, dynamic> json;

  @override
  Map<String, dynamic> toJson() => json;
}
