// ignore_for_file: invalid_annotation_target
import 'package:color_blindness/color_blindness.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// A user using the application.
@freezed
class User with _$User {
  /// A user using the application.
  factory User({
    /// The id of the user
    @JsonKey(name: 'userid') required int id,

    /// The username of the user
    required String username,

    /// The firstname of the user
    required String firstname,

    /// The lastname of the user
    required String lastname,

    /// A bitmask of the capabilities the user has
    @Default(-1) @JsonKey(name: 'capabilities') int capabilitiesBitMask,

    /// The name of the theme the user has selected
    @Default('') @JsonKey(name: 'theme') String themeName,

    /// The language the user has selected
    @Default('') @JsonKey(name: 'lang') String language,

    /// The url of the profile image
    @Default('') @JsonKey(name: 'profileimageurl') String profileImageUrl,

    /// The id of the plan the user is assigned to
    @Default(-1) @JsonKey(name: 'planid') int planId,

    /// The color blindness of the user as a string
    @Default('') @JsonKey(name: 'colorblindness') String colorBlindnessString,

    /// Whether to display the task count in the calendar view
    @Default(1) @JsonKey(name: 'displaytaskcount') int displayTaskCountInt,

    /// The vintage of the user
    @Default('') String vintage,
  }) = _User;

  const User._();

  /// Load a user from json
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// The capabilities the user has
  List<UserCapability> get capabilities {
    final capabilities = <UserCapability>[];

    for (final capability in UserCapability.values) {
      final mask = 1 << capability.index;

      if (capabilitiesBitMask & mask != 0) capabilities.add(capability);
    }

    return capabilities;
  }

  /// The [Locale] to use based on the user's [language].
  Locale get locale => _langToLocale[language] ?? _langToLocale.values.first;

  /// The [ColorBlindnessType] of  user based on [colorBlindnessString].
  ColorBlindnessType get colorBlindness => ColorBlindnessType.values.byName(colorBlindnessString);

  /// Whether to display the task count in the calendar view or not.
  ///
  /// Based on [displayTaskCountInt].
  bool get displayTaskCount => displayTaskCountInt == 1;

  /// Returns `true` if the user has the given [capability]. Otherwise `false`.
  ///
  /// See [UserCapabilitiesExtension.has] for confirming multiple capabilities.
  bool hasCapability(UserCapability capability) => capabilities.contains(capability);

  /// Returns `true` if this user has elevated privileges (i.e. [UserCapability.dev] or [UserCapability.moderator]). Otherwise `false`.
  bool get isElevated => hasCapability(UserCapability.dev) || hasCapability(UserCapability.moderator);

  /// Returns `null` if this user i not valid i.e. [id] is `-1`.
  User? get validOrNull => id == -1 ? null : this;

  /// Returns the full name of the user.
  String get fullname => '$firstname $lastname';
}

const _langToLocale = {
  'en': Locale('en', 'US'),
  'de': Locale('de', 'DE'),
};

/// Represents the different capabilities a user can possess within the application.
///
/// Each capability grants the user specific access rights and features tailored to their role.
enum UserCapability {
  /// Users with this capability are members of the development team.
  ///
  /// They have exclusive access to development-specific features and statistics.
  ///
  /// This role is typically reserved for those involved in the app's development and maintenance.
  dev,

  /// Users with this capability act as moderators within the platform.
  ///
  /// For example, they have the authority to access and manage user feedback.
  ///
  /// and perform other moderation tasks.
  moderator,

  /// Teacher Capability
  ///
  /// Users with this capability are recognized as teachers or educators.
  ///
  /// They have access to features that allow them to e.g. manage and create time slots.
  teacher,

  /// Users with this capability are identified as students or learners.
  ///
  /// They can access features tailored to their planning experience (e.g. the calendar view)
  student,
}

/// Provides helper methods for [List<UserCapability>].
extension UserCapabilitiesExtension on List<UserCapability> {
  /// Returns `true` if [UserCapability.dev] is one of the capabilities the user has. Otherwise `false`.
  bool get hasDev => contains(UserCapability.dev);

  /// Returns `true` if the list contains [UserCapability.moderator]. Otherwise `false`.
  bool get hasModerator => contains(UserCapability.moderator);

  /// Returns `true` if the list contains [UserCapability.teacher]. Otherwise `false`.
  bool get hasTeacher => contains(UserCapability.teacher);

  /// Returns `true` if the list contains [UserCapability.student]. Otherwise `false`.
  bool get hasStudent => contains(UserCapability.student);

  /// Returns `true` if the list contains all of the given [capabilities]. Otherwise `false`.
  bool has(List<UserCapability> capabilities) => capabilities.every(contains);

  /// Returns the highest [UserCapability] in the list.
  ///
  /// If the list is empty, [UserCapability.student] is returned.
  UserCapability get highest => reduce((value, element) => value.index < element.index ? value : element);
}

/// Provides helper methods for [UserCapability].
extension UserCapabilityExtension on UserCapability {
  /// Returns `true` if this capability is [UserCapability.dev]. Otherwise `false`.
  bool get isDev => this == UserCapability.dev;

  /// Returns `true` if this capability is [UserCapability.moderator]. Otherwise `false`.
  bool get isModerator => this == UserCapability.moderator;

  /// Returns `true` if this capability is [UserCapability.teacher]. Otherwise `false`.
  bool get isTeacher => this == UserCapability.teacher;

  /// Returns `true` if this capability is [UserCapability.student]. Otherwise `false`.
  bool get isStudent => this == UserCapability.student;
}
