import 'dart:developer';

import 'package:error_case/error_case.dart';
import 'package:error_case/exception/error_case_exception.dart';

class ObjectSingleErrorReturnCase extends SingleErrorReturnCase {
  const ObjectSingleErrorReturnCase(
      {required this.requiredFields,
      Map<String, num?> minimumValue = const {},
      Map<String, num?> maximumValue = const {}})
      : super(minimumValue, maximumValue);

  final List<String> requiredFields;

  @override
  R validate<T extends JsonModel, R>(T value, R Function(Exception ex) onError,
      R Function(T value) onSuccess) {
    final json = value.toJson();

    try {
      if (requiredFields.isEmpty) {
        throw NoRequiredFieldsError('$runtimeType');
      }

      for (String key in requiredFields) {
        if (key.contains('.')) {
          validateNestedKeyValue(key, json);
        } else {
          validateKeyValue(key, json[key]);
        }
      }
      return onSuccess(value);
    } on NoRequiredFieldsError {
      rethrow;
    } on ErrorCaseException catch (ex) {
      return onError(ex);
    } catch (ex, stackTrace) {
      log('Unknown exception from error case', stackTrace: stackTrace);
      return onError(Exception('Unknown exception from error case'));
    }
  }
}
