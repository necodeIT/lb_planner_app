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
    Vintage? vintage,
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

/// Represents a "Jahrgang" (grade level or class year) in a high school context.
/// Used to denote the year group (or class) of students within a high school.
enum Vintage {
  // Without suffix
  /// The first year.
  @JsonValue(1)
  $1(1),

  /// The second year.
  @JsonValue(2)
  $2(2),

  /// The third year.
  @JsonValue(3)
  $3(3),

  /// The fourth year.
  @JsonValue(4)
  $4(4),

  /// The fifth year.
  @JsonValue(5)
  $5(5),

  // With suffix
  /// The first year, AHIT.
  @JsonValue('1AHIT')
  $1ahit(1, 'AHIT'),

  /// The first year, BHIT.
  @JsonValue('1BHIT')
  $1bhit(1, 'BHIT'),

  /// The first year, CHIT.
  @JsonValue('1CHIT')
  $1chit(1, 'CHIT'),

  /// The first year, DHIT.
  @JsonValue('1DHIT')
  $1dhit(1, 'DHIT'),

  /// The second year, AHIT.
  @JsonValue('2AHIT')
  $2ahit(2, 'AHIT'),

  /// The second year, BHIT.
  @JsonValue('2BHIT')
  $2bhit(2, 'BHIT'),

  /// The second year, CHIT.
  @JsonValue('2CHIT')
  $2chit(2, 'CHIT'),

  /// The second year, DHIT.
  @JsonValue('2DHIT')
  $2dhit(2, 'DHIT'),

  /// The third year, AHIT.
  @JsonValue('3AHIT')
  $3ahit(3, 'AHIT'),

  /// The third year, BHIT.
  @JsonValue('3BHIT')
  $3bhit(3, 'BHIT'),

  /// The third year, CHIT.
  @JsonValue('3CHIT')
  $3chit(3, 'CHIT'),

  /// The third year, DHIT.
  @JsonValue('3DHIT')
  $3dhit(3, 'DHIT'),

  /// The fourth year, AHIT.
  @JsonValue('4AHIT')
  $4ahit(4, 'AHIT'),

  /// The fourth year, BHIT.
  @JsonValue('4BHIT')
  $4bhit(4, 'BHIT'),

  /// The fourth year, CHIT.
  @JsonValue('4CHIT')
  $4chit(4, 'CHIT'),

  /// The fourth year, DHIT.
  @JsonValue('4DHIT')
  $4dhit(4, 'DHIT'),

  /// The fifth year, AHIT.
  @JsonValue('5AHIT')
  $5ahit(5, 'AHIT'),

  /// The fifth year, BHIT.
  @JsonValue('5BHIT')
  $5bhit(5, 'BHIT'),

  /// The fifth year, CHIT.
  @JsonValue('5CHIT')
  $5chit(5, 'CHIT'),

  /// The fifth year, DHIT.
  @JsonValue('5DHIT')
  $5dhit(5, 'DHIT');

  /// The year group's index.
  final int value;

  /// The year group's suffix (e.g., "AHIT").
  final String suffix;

  const Vintage(this.value, [this.suffix = '']);

  /// The human-readable name of this vintage.
  String get humanReadable => '$value${suffix.toUpperCase()}';

  /// Returns `true` if [value] is the same as [other]'s [value].
  ///
  /// As opposed to `==`, this method does not compare the [suffix].
  bool sameVintage(Vintage other) => value == other.value;

  /// Returns `true` if [value] is less than [other]'s [value].
  bool operator <(Vintage other) => value < other.value;

  /// Returns `true` if [value] is less than or equal to [other]'s [value].
  bool operator <=(Vintage other) => value <= other.value;

  /// Returns `true` if [value] is greater than [other]'s [value].
  bool operator >(Vintage other) => value > other.value;

  /// Returns `true` if [value] is greater than or equal to [other]'s [value].
  bool operator >=(Vintage other) => value >= other.value;
}
