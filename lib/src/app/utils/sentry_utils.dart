import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Extension methods for [ILoggable] that integrate with Sentry.
extension SentryUtils on ILoggable {
  /// Starts a new transaction with the given [task] and returns a [ISentrySpan] that can be used to finish the transaction.
  ISentrySpan startTransaction(String task) => Sentry.getSpan()?.startChild(task) ?? Sentry.startTransaction(namespace, task);
}

/// Utility methods for [ISentrySpan].
extension TransactionX on ISentrySpan {
  /// Sets the status of this transaction to [SpanStatus.internalError].
  void internalError(Object throwable) {
    status = const SpanStatus.internalError();
    this.throwable = throwable;
  }
}
