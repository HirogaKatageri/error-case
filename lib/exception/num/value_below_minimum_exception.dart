import 'package:error_case/exception/error_case_exception.dart';

class ValueBelowMinimumException extends ErrorCaseException {
  ValueBelowMinimumException(errorCaseName, requiredFieldName)
      : super(errorCaseName, requiredFieldName: requiredFieldName);

  @override
  String toString() =>
      "Field '$requiredFieldName' in $errorCaseName is below minimum value";
}
