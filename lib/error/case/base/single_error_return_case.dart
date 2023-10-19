import 'package:error_case/error_case.dart';

/// This is used to define an error case that returns a single exception
/// and stop validation at first error.
abstract class SingleErrorReturnCase extends ErrorCase {
  const SingleErrorReturnCase(
    Map<String, num?> minimumValue,
    Map<String, num?> maximumValue,
  ) : super(minimumValue, maximumValue);

  R validate<T, R>(
    dynamic value,
    R Function(Exception ex) onError,
    R Function(T value) onSuccess,
  );
}
