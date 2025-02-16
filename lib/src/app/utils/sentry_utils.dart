import 'dart:async';

import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Extension methods for [ILoggable] that integrate with Sentry.
extension SentryUtils on ILoggable {
  /// Starts a new transaction with the given [task] and returns a [ISentrySpan] that can be used to finish the transaction.
  ISentrySpan startTransaction(String task) =>
      Sentry.getSpan()?.startChild(task) ??
      Sentry.startTransaction(
        namespace,
        task,
        bindToScope: true,
        waitForChildren: true,
      );

  /// Runs the provided [execute] function in a transaction with the given [task].
  ///
  /// This method will automatically commit the transaction after the function completes.
  /// If an error occurs, the transaction will be marked as an internal error and rethrown.
  /// If [execute] completes successfully, the transaction will be marked as [SpanStatus.ok] and the result will be returned.
  Future<T> transaction<T>(String task, FutureOr<T> Function() execute, {T? Function(Object, StackTrace)? onError}) async {
    final transaction = startTransaction(task);
    try {
      return await execute();
    } catch (e) {
      transaction.internalError(e);

      final errorResult = onError?.call(e, StackTrace.current);

      if (errorResult != null) {
        return errorResult;
      } else {
        rethrow;
      }
    } finally {
      await transaction.commit();
    }
  }
}

/// Utility methods for [ISentrySpan].
extension TransactionX on ISentrySpan {
  /// Sets the status of this transaction to [SpanStatus.internalError].
  void internalError(Object throwable) {
    status = const SpanStatus.internalError();
    this.throwable = throwable;
  }

  /// Finishes the transaction and sets the status to [SpanStatus.ok] if no status was set.
  /// Use this over [finish] to ensure that a status is set.
  Future<void> commit() async {
    status ??= const SpanStatus.ok();

    await finish();
  }
}
