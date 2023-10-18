import 'package:error_case/error_case.dart';

/// This is used to define an error case that returns a single exception
/// and stop validation at first error.
abstract class SingleErrorCase extends ErrorCase {
  const SingleErrorCase(
    Map<String, num?> minimumValue,
    Map<String, num?> maximumValue,
  ) : super(minimumValue, maximumValue);

  void validate<T extends JsonModel>(
    T value,
    Function(Exception exception) onError,
    Function(T value) onSuccess,
  );
}
