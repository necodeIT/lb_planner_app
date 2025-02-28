import 'package:freezed_annotation/freezed_annotation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

/// A token to authenticate with a [Webservice].
@freezed
class Token with _$Token {
  /// A token to authenticate with a [Webservice].
  const factory Token({
    /// The access token
    required String token,

    /// The [Webservice] the token is valid for
    required Webservice webservice,
  }) = _Token;

  const Token._();

  /// Load a token from json
  factory Token.fromJson(Map<String, Object?> json) => _$TokenFromJson(json);
}

/// An API endpoint exposed by a moodle plugin.
///
/// See [https://docs.moodle.org/404/en/Web_services](https://docs.moodle.org/404/en/Web_services)
enum Webservice {
  /// The built-in moodle [webservice](https://docs.moodle.org/dev/Web_service_API_functions)
  // ignore: constant_identifier_names
  moodle_mobile_app,

  /// Our own inhouse webservice.
  ///
  /// See [https://github.com/necodeIT/lb_planner_plugin](https://github.com/necodeIT/lb_planner_plugin)
  // ignore: constant_identifier_names
  lb_planner_api,
}
