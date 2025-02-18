import 'dart:async';

import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

/// A mixin that adds transaction tracing to a class.
mixin Tracable on ILoggable {
  ISentrySpan? _transaction;

  /// The parent tracable to attach transactions to.
  Tracable? parent;

  /// Starts a new transaction with the given [task] and returns a [ISentrySpan] that can be used to finish the transaction.
  ISentrySpan startTransaction(String task) {
    final transaction = parent?._transaction?.startChild(
          task,
          description: 'Called in $namespace.$runtimeType',
        ) ??
        Sentry.startTransaction(
          '$namespace.$runtimeType',
          task,
          description: 'Called in $namespace.$runtimeType',
          waitForChildren: true,
          onFinish: (_) {
            _transaction = null;
          },
        );

    _transaction = transaction;

    return transaction;
  }
}
