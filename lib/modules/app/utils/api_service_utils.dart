import 'package:either_dart/either.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Utility functions for [Either<List<JSON>, JSON>].
///
/// Mainly renames the [Either] methods to be more descriptive for the context of an API service.
extension ApiServiceResponseUtils on Either<List<JSON>, JSON> {
  /// Returns the response as a list of JSON objects.
  ///
  /// May throw an exception if [isList] is `false`.
  List<JSON> get asList => left;

  /// Returns the response as a JSON object.
  ///
  /// May throw an exception if [isJson] is `false`.
  JSON get asJson => right;

  /// Returns the response as a JSON object or null if [isJson] is `false`.
  JSON? get asJsonOrNull => isRight ? right : null;

  /// Returns the response as a list of JSON objects or null if the response is not a list.
  ///
  /// May throw an exception if [isList] is `false`.
  List<JSON>? get asListOrNull => isLeft ? left : null;

  /// Returns `true` if the response is a JSON object.
  bool get isJson => isRight;

  /// Returns `true` if the response is a list of JSON objects.
  bool get isList => isLeft;
}
