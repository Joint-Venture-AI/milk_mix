// Result classes for handling success and failure states
abstract class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => isSuccess ? (this as Success<T>).data : null;
  String? get error => isFailure ? (this as Failure<T>).error : null;
  int? get statusCode => isFailure ? (this as Failure<T>).statusCode : null;

  when({
    required Function(Success<T>) onSuccess,
    required Function(Failure<T>) onFailure,
  }) {
    if (isSuccess) {
      onSuccess(this as Success<T>);
    } else {
      onFailure(this as Failure<T>);
    }
  }
}

class Success<T> extends Result<T> {
  final T data;
  final int statusCode;
  final Map<String, String>? headers;

  const Success(this.data, {this.statusCode = 200, this.headers});

  @override
  String toString() => 'Success(data: $data, statusCode: $statusCode)';
}

class Failure<T> extends Result<T> {
  final String error;
  final int? statusCode;
  final Map<String, String>? headers;
  final FailureType type;

  const Failure(
    this.error, {
    this.statusCode,
    this.headers,
    this.type = FailureType.unknown,
  });

  @override
  String toString() =>
      'Failure(error: $error, statusCode: $statusCode, type: $type)';
}

enum FailureType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  serverError,
  parsing,
  unknown,
}
