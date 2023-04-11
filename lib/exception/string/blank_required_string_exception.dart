import 'package:error_case/exception/error_case_exception.dart';

class BlankRequiredStringException extends ErrorCaseException {
  BlankRequiredStringException(errorCaseName, requiredFieldName)
      : super(errorCaseName, requiredFieldName: requiredFieldName);

  @override
  String toString() => "Field '$requiredFieldName' in $errorCaseName is blank.";
}
