import 'package:error_case/exception/error_case_exception.dart';

abstract class ErrorCase {
  const ErrorCase(this.minimumValue, this.maximumValue);

  final Map<String, num?> minimumValue;
  final Map<String, num?> maximumValue;

  void validateNestedKeyValue(String key, Map<String, dynamic> json) {
    var keys = key.split('.');

    Map<String, dynamic> nJson = json;
    int index = 0;

    for (String nKey in keys) {
      index += 1;
      if (index == keys.length) {
        validateKeyValue(key, nJson[nKey]);
      } else {
        nJson = nJson[nKey];
      }
    }
  }

  void validateKeyValue(String key, dynamic keyValue) {
    switch (keyValue) {
      case null:
        throw NullRequiredFieldException('$runtimeType', key);
      default:
        _validateAndCheckType(key, keyValue);
        break;
    }
  }

  void _validateAndCheckType(String key, dynamic value) {
    if (value is String) {
      _validateString(key, value);
    } else if (value is num) {
      _validateNum(key, value);
    } else if (value is Map) {
      _validateMap(key, value);
    } else if (value is List) {
      _validateList(key, value);
    }
  }

  void _validateString(String key, String value) {
    if (value.isEmpty) {
      throw BlankRequiredStringException('$runtimeType', key);
    }
  }

  void _validateNum(String key, num value) {
    var minValue = minimumValue[key];
    var maxValue = maximumValue[key];

    if (minValue != null && value < minValue) {
      throw ValueBelowMinimumException('$runtimeType', key);
    }

    if (maxValue != null && value > maxValue) {
      throw ValueAboveMaximumException('$runtimeType', key);
    }
  }

  void _validateMap(String key, Map value) {
    if (value.isEmpty) {
      throw EmptyRequiredListException('$runtimeType', key);
    }
  }

  void _validateList(String key, List value) {
    if (value.isEmpty) {
      throw EmptyRequiredListException('$runtimeType', key);
    }
  }
}
