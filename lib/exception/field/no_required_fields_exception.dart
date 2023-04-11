class NoRequiredFieldsError extends Error {
  NoRequiredFieldsError(this.errorCaseName) : super();

  final String errorCaseName;

  @override
  String toString() => '$errorCaseName does not have any required fields. '
      'You must define required fields before calling validate().';
}
