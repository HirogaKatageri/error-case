abstract class ErrorCaseException implements Exception {
  ErrorCaseException(this.errorCaseName, {this.requiredFieldName = ''});

  final String errorCaseName;
  final String requiredFieldName;
}
