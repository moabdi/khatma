import 'package:flutter/material.dart';

/// Generic Result type for handling success/failure operations
/// This replaces throwing exceptions with explicit error handling
sealed class Result<T, E> {
  const Result();

  /// Creates a successful result
  const factory Result.success(T data) = Success<T, E>;

  /// Creates a failure result
  const factory Result.failure(E error) = Failure<T, E>;

  /// Returns true if this is a success result
  bool get isSuccess => this is Success<T, E>;

  /// Returns true if this is a failure result
  bool get isFailure => this is Failure<T, E>;

  /// Gets the data if success, null otherwise
  T? get dataOrNull => switch (this) {
        Success<T, E>(data: final data) => data,
        Failure<T, E>() => null,
      };

  /// Gets the error if failure, null otherwise
  E? get errorOrNull => switch (this) {
        Success<T, E>() => null,
        Failure<T, E>(error: final error) => error,
      };

  /// Maps the success value to another type
  Result<U, E> map<U>(U Function(T) mapper) => switch (this) {
        Success<T, E>(data: final data) => Result.success(mapper(data)),
        Failure<T, E>(error: final error) => Result.failure(error),
      };

  /// Maps the error value to another type
  Result<T, U> mapError<U>(U Function(E) mapper) => switch (this) {
        Success<T, E>(data: final data) => Result.success(data),
        Failure<T, E>(error: final error) => Result.failure(mapper(error)),
      };

  /// Executes callback if success
  Result<T, E> onSuccess(void Function(T) callback) {
    if (this case Success<T, E>(data: final data)) {
      callback(data);
    }
    return this;
  }

  /// Executes callback if failure
  Result<T, E> onFailure(void Function(E) callback) {
    if (this case Failure<T, E>(error: final error)) {
      callback(error);
    }
    return this;
  }

  /// Converts to Future for async operations
  Future<Result<T, E>> toFuture() => Future.value(this);
}

final class Success<T, E> extends Result<T, E> {
  const Success(this.data);
  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Success<T, E> && data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() => 'Success($data)';

  static void showSuccessMessage(
    BuildContext context,
    String message, [
    Duration? duration,
  ]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: duration ?? const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

final class Failure<T, E> extends Result<T, E> {
  const Failure(this.error);
  final E error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Failure<T, E> && error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}

// =====================================================
// EXTENSION POUR RESULT AVEC FUTURE
// =====================================================

extension FutureResult<T, E> on Future<Result<T, E>> {
  /// Maps the success value asynchronously
  Future<Result<U, E>> mapAsync<U>(Future<U> Function(T) mapper) async {
    final result = await this;
    return switch (result) {
      Success<T, E>(data: final data) => Result.success(await mapper(data)),
      Failure<T, E>(error: final error) => Result.failure(error),
    };
  }

  /// Chains multiple operations that return Results
  Future<Result<U, E>> andThen<U>(Future<Result<U, E>> Function(T) next) async {
    final result = await this;
    return switch (result) {
      Success<T, E>(data: final data) => await next(data),
      Failure<T, E>(error: final error) => Result.failure(error),
    };
  }
}
