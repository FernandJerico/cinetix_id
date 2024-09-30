sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success;
  const factory Result.failed(String message) = Failed;

  bool get isSuccess => this is Success<T>;
  bool get isFailed => this is Failed<T>;

  T? get resultValue => isSuccess ? (this as Success<T>).data : null;
  String? get errorMessage => isFailed ? (this as Failed<T>).message : null;
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failed<T> extends Result<T> {
  final String message;

  const Failed(this.message);
}
