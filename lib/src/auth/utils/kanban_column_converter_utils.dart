import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Converts a nullable [KanbanColumn] to a string and vice versa.
///
/// If the value is null it returns an empty string.
class KanbanColumnConverter extends IGenericSerializer<KanbanColumn?, String> {
  /// Converts a nullable [KanbanColumn] to a string and vice versa.
  ///
  /// If the value is null it returns an empty string.
  const KanbanColumnConverter();

  @override
  String serialize(KanbanColumn? data) {
    return data?.name ?? '';
  }

  @override
  KanbanColumn? deserialize(String data) {
    return KanbanColumn.values.asNameMap()[data];
  }
}
