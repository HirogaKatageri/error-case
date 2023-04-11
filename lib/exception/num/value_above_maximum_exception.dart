import 'package:error_case/exception/error_case_exception.dart';

class ValueAboveMaximumException extends ErrorCaseException {
  ValueAboveMaximumException(errorCaseName, requiredFieldName)
      : super(errorCaseName, requiredFieldName: requiredFieldName);

  @override
  String toString() =>
      "Field '$requiredFieldName' in $errorCaseName is above maximum value";
}
