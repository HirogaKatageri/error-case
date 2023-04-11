import 'package:error_case/exception/base/error_case_exception.dart';

class EmptyRequiredListException extends ErrorCaseException {
  EmptyRequiredListException(errorCaseName, requiredFieldName)
      : super(errorCaseName, requiredFieldName: requiredFieldName);

  @override
  String toString() =>
      "Field '$requiredFieldName' in $errorCaseName is an empty List";
}
