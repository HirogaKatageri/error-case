import 'package:test/test.dart';
import 'package:error_case/error_case.dart';
import 'package:error_case/exception/error_case_exception.dart';

class Person {
  Person(this.name, this.age);

  final String name;
  final int age;

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}

void main() {
  group('ObjectSingleErrorReturnCase', () {
    late ObjectSingleErrorReturnCase objectSingleErrorReturnCase;

    setUp(() {
      objectSingleErrorReturnCase =
          ObjectSingleErrorReturnCase(requiredFields: ['name', 'age']);
    });

    test('validate should succeed with valid input', () {
      var person = Person('John', 30);
      var result = objectSingleErrorReturnCase.validate<Person, String>(
        person,
        (ex) => fail('Unexpected error: $ex'),
        (value) => 'Success',
      );

      expect(result, equals('Success'));
    });

    test(
        'validate should throw NoRequiredFieldsError if requiredFields is empty',
        () {
      var person = Person('John', 30);
      var errorCase = ObjectSingleErrorReturnCase(requiredFields: []);

      expect(
        () => errorCase.validate<Person, dynamic>(
          person,
          (ex) => fail('Unexpected error: $ex'),
          (value) => 'Success',
        ),
        throwsA(const TypeMatcher<NoRequiredFieldsError>()),
      );
    });

    test('validate should return BlankRequiredStringException if name is empty',
        () {
      var person = Person('', 30);
      expect(
        objectSingleErrorReturnCase.validate<Person, dynamic>(
          person,
          (ex) => ex,
          (value) => fail('Should return exception'),
        ),
        const TypeMatcher<BlankRequiredStringException>(),
      );
    });

    test(
        'validate should return ValueBelowMinimumException if age is less than minimum',
        () {
      var person = Person('John', 10);
      objectSingleErrorReturnCase = ObjectSingleErrorReturnCase(
        requiredFields: ['name', 'age'],
        minimumValue: {'age': 18},
      );
      expect(
        objectSingleErrorReturnCase.validate<Person, dynamic>(
          person,
          (ex) => ex,
          (value) => fail('Should throw exception'),
        ),
        const TypeMatcher<ValueBelowMinimumException>(),
      );
    });

    test('validate should return onError result if exception is thrown', () {
      var person = Person('', 30);
      expect(
        objectSingleErrorReturnCase.validate<Person, String>(
          person,
          (ex) => 'Error: $ex',
          (value) => fail('Should throw exception'),
        ),
        equals(
          "Error: Field 'name' in ObjectSingleErrorReturnCase is blank.",
        ),
      );
    });

    test('validate should return onSuccess result if no exception is thrown',
        () {
      var person = Person('John', 30);
      expect(
        objectSingleErrorReturnCase.validate<Person, String>(
          person,
          (ex) => fail('Unexpected error: $ex'),
          (value) => 'Success',
        ),
        equals('Success'),
      );
    });
  });
}
