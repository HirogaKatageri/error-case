import 'package:error_case/exception/error_case_exception.dart';

class NullRequiredFieldException extends ErrorCaseException {
  NullRequiredFieldException(errorCaseName, requiredFieldName)
      : super(errorCaseName, requiredFieldName: requiredFieldName);

  @override
  String toString() => "Field '$requiredFieldName' in $errorCaseName is null.";
}
