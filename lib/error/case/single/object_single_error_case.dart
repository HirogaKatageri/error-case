import 'dart:developer';

import 'package:error_case/error_case.dart';
import 'package:error_case/exception/error_case_exception.dart';

class ObjectSingleErrorCase extends SingleErrorCase {
  const ObjectSingleErrorCase({
    required this.requiredFields,
    Map<String, num?> minimumValue = const {},
    Map<String, num?> maximumValue = const {},
  }) : super(minimumValue, maximumValue);

  final List<String> requiredFields;

  @override
  void validate<T>(
    dynamic value,
    Function(Exception ex) onError,
    Function(T value) onSuccess,
  ) {
    var json = value.toJson();
    var isErrorThrown = false;

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
    } on NoRequiredFieldsError {
      rethrow;
    } on ErrorCaseException catch (ex) {
      isErrorThrown = true;
      onError.call(ex);
    } catch (ex, stackTrace) {
      isErrorThrown = true;
      log('Unknown exception from error case', stackTrace: stackTrace);
      onError.call(Exception('Unknown exception from error case'));
    }

    if (!isErrorThrown) {
      onSuccess.call(value);
    }
  }
}
