import 'package:error_case/error_case.dart';

abstract class SingleErrorReturnCase extends ErrorCase {
  const SingleErrorReturnCase(
    Map<String, num?> minimumValue,
    Map<String, num?> maximumValue,
  ) : super(minimumValue, maximumValue);

  R validate<T extends JsonModel, R>(
    T value,
    R Function(Exception ex) onError,
    R Function(T value) onSuccess,
  );
}
