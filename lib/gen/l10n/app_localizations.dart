import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en')
  ];

  /// Global confirmation button label.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get global_confirm;

  /// Global continue button label.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get global_continue;

  /// Global create button label.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get global_create;

  /// Global update button label.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get global_update;

  /// Global cancel button label.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get global_cancel;

  /// Global close button label.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get global_close;

  /// Global search label.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get global_search;

  /// Global OK button label.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get global_ok;

  /// Global dismiss button label.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get global_dismiss;

  /// Global text for 'Not Available' or 'Not Applicable'.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get global_nA;

  /// Global loading indicator text.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get global_loading;

  /// Global edit button label.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get global_edit;

  /// Global delete button label.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get global_delete;

  /// Title bar label for Pro version.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get app_titleBar_pro;

  /// Title bar label for Trial version.
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get app_titleBar_trial;

  /// Prompt to update the application image using the provided download URL.
  ///
  /// In en, this message translates to:
  /// **'Download the [latest version]({url}) and replace the current version with the new one.'**
  String app_update_appImage(String url);

  /// Instruction to update the application via the AUR package manager.
  ///
  /// In en, this message translates to:
  /// **'Run `yay -S lb-planner` to update to the latest version.'**
  String get app_update_aur;

  /// Prompt to download and install the latest version using the provided URL.
  ///
  /// In en, this message translates to:
  /// **'Download the [latest version]({url}) and install it.'**
  String app_update_download(String url);

  /// Instruction for updating the web version by refreshing the page.
  ///
  /// In en, this message translates to:
  /// **'Please refresh the page with `Ctrl + Shift + F5` to update to the latest version.'**
  String get app_update_web;

  /// No description provided for @app_noMobile_message.
  ///
  /// In en, this message translates to:
  /// **'This feature is not available on mobile devices.'**
  String get app_noMobile_message;

  /// No description provided for @app_noMobile_goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get app_noMobile_goBack;

  /// Access restriction message that uses the app name placeholder.
  ///
  /// In en, this message translates to:
  /// **'You are not allowed to use {appname}. If you believe this is an error, please contact your Moodle administrator to request access.'**
  String auth_accessHint(String appname);

  /// Label for the username input field.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get auth_username;

  /// Label for the password input field.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password;

  /// Login button label.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get auth_login;

  /// Subtitle guiding users to log in with their Moodle account.
  ///
  /// In en, this message translates to:
  /// **'Login with your Moodle account.'**
  String get auth_subtitle;

  /// Error message for invalid login credentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get auth_invalidCredentials;

  /// Displays the current version of the application with a version placeholder.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String auth_version(String version);

  /// Consent text for data collection and processing.
  ///
  /// In en, this message translates to:
  /// **'I accept the collection and processing of my data as described in the '**
  String get auth_dataCollectionConsent;

  /// Suffix to the consent string
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get auth_dataCollectionConsentSuffix;

  /// Label for the privacy policy link.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get auth_privacyPolicy;

  /// Label for the calendar plan section.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get calendar_plan;

  /// Label for the overview of tasks in the calendar.
  ///
  /// In en, this message translates to:
  /// **'Tasks Overview'**
  String get calendar_tasksOverview;

  /// Title for the description of the tasks overview.
  ///
  /// In en, this message translates to:
  /// **'What is this?'**
  String get calendar_tasksOverview_description_title;

  /// Detailed explanation of what the tasks overview displays.
  ///
  /// In en, this message translates to:
  /// **'The tasks overview shows the distribution of tasks over the months based on the deadlines set by the teachers.'**
  String get calendar_tasksOverview_description;

  /// Title for the calendar view.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar_title;

  /// Label for inviting someone to a plan.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get calendar_invite;

  /// Button label to leave a plan.
  ///
  /// In en, this message translates to:
  /// **'Leave Plan'**
  String get calendar_leave;

  /// Confirmation title when attempting to leave a plan.
  ///
  /// In en, this message translates to:
  /// **'Leave plan?'**
  String get calendar_leave_title;

  /// Confirmation message for leaving a plan.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave this plan? This action cannot be undone.\nBut no worries a copy of the shared plan will be saved to your account and you can be invited back at any time.'**
  String get calendar_leave_message;

  /// Status label indicating that a user has been invited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get calendar_invited;

  /// Status label indicating that a plan is part of your schedule.
  ///
  /// In en, this message translates to:
  /// **'In your plan'**
  String get calendar_inYourPlan;

  /// Label showing the number of tasks, with pluralization based on count.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No Tasks} one{1 Task} other{{count} Tasks}}'**
  String calendar_tasksCountLabel(int count);

  /// Button label to remove a task's deadline.
  ///
  /// In en, this message translates to:
  /// **'Remove deadline'**
  String get calendar_removeDeadline;

  /// Button label to invite users to join a plan.
  ///
  /// In en, this message translates to:
  /// **'Invite users'**
  String get calendar_inviteUsers;

  /// Placeholder or label for searching users.
  ///
  /// In en, this message translates to:
  /// **'Search users'**
  String get calendar_searchUsers;

  /// Placeholder or label for searching members within a plan.
  ///
  /// In en, this message translates to:
  /// **'Search members'**
  String get calendar_searchMembers;

  /// Placeholder or label for searching tasks.
  ///
  /// In en, this message translates to:
  /// **'Search tasks'**
  String get calendar_searchTasks;

  /// Button label to clear all tasks from a plan.
  ///
  /// In en, this message translates to:
  /// **'Clear Plan'**
  String get calendar_clearPlan;

  /// Confirmation title for clearing a plan.
  ///
  /// In en, this message translates to:
  /// **'Clear plan?'**
  String get calendar_clearPlan_title;

  /// Confirmation message for clearing a plan.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear your plan? This will remove all planned tasks and cannot be undone.'**
  String get calendar_clearPlan_message;

  /// Label for tasks section in the calendar.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get calendar_tasks;

  /// Label for members section in the calendar.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get calendar_members;

  /// Column header for course name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get courses_name;

  /// Column header for course type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get courses_type;

  /// Column header for course status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get courses_status;

  /// Column header for course due date.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get courses_dueDate;

  /// Column header for planned due date of a course.
  ///
  /// In en, this message translates to:
  /// **'Planned due date'**
  String get courses_plannedDueDate;

  /// Title for the course overview section.
  ///
  /// In en, this message translates to:
  /// **'Course Overview'**
  String get courses_overview;

  /// Section title for today's tasks on the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks'**
  String get dashboard_todaysTasks;

  /// Message displayed when no tasks are planned for today.
  ///
  /// In en, this message translates to:
  /// **'You\'ve nothing planned for today'**
  String get dashboard_todaysTasks_noTasks;

  /// Title for the status overview section on the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Status overview'**
  String get dashboard_statusOverview;

  /// Title for the burndown chart displayed on the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Burndown chart'**
  String get dashboard_burnDownChart;

  /// Label for the planned trajectory line in the burndown chart.
  ///
  /// In en, this message translates to:
  /// **'Planned trajectory'**
  String get dashboard_burnDownChart_plannedTrajectory;

  /// Label for the ideal daily task completion rate in the burndown chart, showing tasks per day.
  ///
  /// In en, this message translates to:
  /// **'Ideal trajectory {count, plural, other{({count} tasks/day)} one{({count} task/day)}}'**
  String dashboard_burnDownChart_idealTrajectory(num count);

  /// Title for the explanation of the burndown chart.
  ///
  /// In en, this message translates to:
  /// **'WTF is a burndown chart?'**
  String get dashboard_burnDownChart_explanation_title;

  /// Detailed explanation of how the burndown chart works.
  ///
  /// In en, this message translates to:
  /// **'The **burndown chart** helps you visualize your progress toward completing tasks.\n\n1. The **ideal trajectory** (straight line) shows how many tasks you should have left each day if you\'ve planned your tasks in an ideal way to keep a steady workload.\n2. The **planned trajectory** (curved line) shows how many tasks you\'re expected to have left based on when you\'ve planned to complete them.\n\t- Green when no tasks are remaining by the end of the semester.\n\t- Becomes red if you will not complete all modules in time.\n\nThis chart doesn’t track when tasks are actually completed—it\'s all about comparing your plan to the ideal pace so you can stay on track!\n'**
  String get dashboard_burnDownChart_explanation_message;

  /// Section title for upcoming exams on the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Upcoming exams'**
  String get dashboard_exams;

  /// Message displayed when there are no upcoming exams.
  ///
  /// In en, this message translates to:
  /// **'No exams scheduled in the near future'**
  String get dashboard_exams_noExams;

  /// Title for the dashboard view.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard_title;

  /// Section title for overdue tasks on the dashboard.
  ///
  /// In en, this message translates to:
  /// **'Overdue tasks'**
  String get dashboard_overdueTasks;

  /// Message displayed when there are no overdue tasks.
  ///
  /// In en, this message translates to:
  /// **'You\'re all good, no tasks are overdue!'**
  String get dashboard_noTasksOverdue;

  /// Label for the number of reserved slots for today.
  ///
  /// In en, this message translates to:
  /// **'Slots reserved for today'**
  String get dashboard_slotsReservedToday;

  /// Message displayed when there are no slots reserved for today.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any slots reserved for today.'**
  String get dashboard_noSlotsReservedToday;

  /// Status label indicating that a task is completed.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get enum_taskStatus_done;

  /// Status label indicating that a task is pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get enum_taskStatus_pending;

  /// Status label indicating that a task has been uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get enum_taskStatus_uploaded;

  /// Status label indicating that a task is overdue.
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get enum_taskStatus_late;

  /// Instruction to select courses on the Moodle course selection screen.
  ///
  /// In en, this message translates to:
  /// **'Select courses'**
  String get moodle_courseSelectionScreen_selectCourses;

  /// Placeholder or label for searching courses in Moodle.
  ///
  /// In en, this message translates to:
  /// **'Search courses'**
  String get moodle_courseSelector_search;

  /// Button label to open a task directly in Moodle.
  ///
  /// In en, this message translates to:
  /// **'Open in Moodle'**
  String get moodle_moodleTaskWidget_openInMoodle;

  /// Abbreviation for required tasks in Moodle (GK).
  ///
  /// In en, this message translates to:
  /// **'GK'**
  String get moodle_task_required;

  /// Abbreviation for optional tasks in Moodle (EK).
  ///
  /// In en, this message translates to:
  /// **'EK'**
  String get moodle_task_optional;

  /// Label for exam tasks in Moodle.
  ///
  /// In en, this message translates to:
  /// **'Exam'**
  String get moodle_task_exam;

  /// Abbreviation for participation tasks in Moodle (M).
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get moodle_task_participation;

  /// Welcome message for new users, including app name and username placeholders.
  ///
  /// In en, this message translates to:
  /// **'Welcome to {appname}, {username}! We hope you enjoy your stay.'**
  String notification_newUser(String appname, String username);

  /// Notification message indicating that a user has invited you to join their plan, includes username.
  ///
  /// In en, this message translates to:
  /// **'{username} invited you to join their plan!'**
  String notification_invite(String username);

  /// Button label to accept an invitation.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get notification_invite_accept;

  /// Button label to decline an invitation.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get notification_invite_decline;

  /// Status label indicating that an invitation has been accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get notification_invite_accepted;

  /// Status label indicating that an invitation has been declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get notification_invite_declined;

  /// Notification that a user's invitation has been accepted, includes username.
  ///
  /// In en, this message translates to:
  /// **'{username} accepted your invitation!'**
  String notification_inviteAccepted(String username);

  /// Notification that a user's invitation has been declined, includes username.
  ///
  /// In en, this message translates to:
  /// **'{username} declined your invitation!'**
  String notification_inviteDeclined(String username);

  /// Notification informing the user that they have been removed from a shared plan, with a copy saved.
  ///
  /// In en, this message translates to:
  /// **'You have been removed from your shared plan. But don\'t worry, we\'ve got you covered - a copy of the plan has been saved to your account.'**
  String get notification_planRemoved;

  /// Notification message when a user leaves a shared plan, includes username.
  ///
  /// In en, this message translates to:
  /// **'{username} left your plan. You can invite them back anytime.'**
  String notification_planLeft(String username);

  /// Title for the notifications list showing the total count of notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications ({count})'**
  String notification_list_title(int count);

  /// Button or link label to filter and show unread notifications.
  ///
  /// In en, this message translates to:
  /// **'Show unread'**
  String get notification_list_showUnread;

  /// Button or link label to show all notifications.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get notification_list_showAll;

  /// Title for the settings section.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Title displayed after feedback is successfully sent.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent'**
  String get settings_feedback_sent_title;

  /// Message displayed after successfully sending feedback, includes the feedback ID placeholder.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback. We will get back to you as soon as possible.\n\nYour feedback ID is: {sentryid}'**
  String settings_feedback_sent_message(String sentryid);

  /// Title displayed when feedback submission fails.
  ///
  /// In en, this message translates to:
  /// **'Unable to send feedback'**
  String get settings_feedback_error_title;

  /// Error message displayed when feedback submission fails.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while sending your feedback and the error has been reported to the developers. Please try again later.'**
  String get settings_feedback_error_message;

  /// Title for the feedback section.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get settings_feedback_title;

  /// Description prompting the user to describe their problem in the feedback form.
  ///
  /// In en, this message translates to:
  /// **'Please describe your problem.'**
  String get settings_feedback_description;

  /// Consent text for sharing personal details with the developers.
  ///
  /// In en, this message translates to:
  /// **'I agree to sharing my email address and name with the developers in accordance with our '**
  String get settings_feedback_consent;

  /// Suffix to the consent string
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get settings_feedback_consentSuffix;

  /// Button label to submit feedback.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get settings_feedback_submit;

  /// Feedback type option for reporting a bug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get settings_feedback_type_bug;

  /// Feedback type option for reporting a typo.
  ///
  /// In en, this message translates to:
  /// **'Typo'**
  String get settings_feedback_type_typo;

  /// Feedback type option for requesting a feature.
  ///
  /// In en, this message translates to:
  /// **'Feature'**
  String get settings_feedback_type_feature;

  /// Feedback type option for other types of feedback.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get settings_feedback_type_other;

  /// General settings section label.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settings_general;

  /// Button label to clear the application cache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get settings_general_clearCache;

  /// Button label to delete the user's profile.
  ///
  /// In en, this message translates to:
  /// **'Delete profile'**
  String get settings_general_deleteProfile;

  /// Label for the credits section.
  ///
  /// In en, this message translates to:
  /// **'Credits'**
  String get settings_general_credits;

  /// Displays the current app version in settings, with version placeholder.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settings_general_version(String version);

  /// Option to enable EK modules in settings.
  ///
  /// In en, this message translates to:
  /// **'Enable EK modules'**
  String get settings_general_enableEK;

  /// Option to toggle the display of the task count.
  ///
  /// In en, this message translates to:
  /// **'Display task count'**
  String get settings_general_displayTaskCount;

  /// Label for theme selection in settings.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// Title for the slots section.
  ///
  /// In en, this message translates to:
  /// **'Slots'**
  String get slots_title;

  /// Displays the number of supervisors assigned to the slot, using a count placeholder.
  ///
  /// In en, this message translates to:
  /// **'Supervisors: {count}'**
  String slots_details_supervisorsCount(int count);

  /// Displays the number of course mappings for the slot, using a count placeholder.
  ///
  /// In en, this message translates to:
  /// **'Mappings: {count}'**
  String slots_details_mappingsCount(int count);

  /// Displays the current reservations over the total slot size, with reservations and size placeholders.
  ///
  /// In en, this message translates to:
  /// **'Reservations ({reservations}/{size})'**
  String slots_details_reservationsCount(int reservations, int size);

  /// Displays the size of the slot, using a count placeholder.
  ///
  /// In en, this message translates to:
  /// **'Size {count}'**
  String slots_details_sizeCount(int count);

  /// Button label to create a new slot.
  ///
  /// In en, this message translates to:
  /// **'New slot'**
  String get slots_slotmaster_newSlot;

  /// Confirmation title for deleting a slot, including room, start unit, and end unit placeholders.
  ///
  /// In en, this message translates to:
  /// **'Delete slot {room} {startUnit} - {endUnit}?'**
  String slots_slotmaster_deleteSlot_title(String room, String startUnit, String endUnit);

  /// Confirmation message for deleting a slot.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this slot? This action cannot be undone.'**
  String get slots_slotmaster_deleteSlot_message;

  /// Button label to edit a slot.
  ///
  /// In en, this message translates to:
  /// **'Edit slot'**
  String get slots_edit_editSlot;

  /// Button label to create a new slot.
  ///
  /// In en, this message translates to:
  /// **'Create a new slot'**
  String get slots_edit_createSlot;

  /// Label for the start time input in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get slots_edit_startTime;

  /// Label for the end time input in slot editing.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get slots_edit_endTime;

  /// Label for selecting the weekday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Weekday'**
  String get slots_edit_weekday;

  /// Label for the room input in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get slots_edit_room;

  /// Label for the size input in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get slots_edit_size;

  /// Label for the supervisors section in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Supervisors'**
  String get slots_edit_supervisors;

  /// Button label to add a supervisor to a slot.
  ///
  /// In en, this message translates to:
  /// **'Add supervisor'**
  String get slots_edit_addSupervisor;

  /// Label for the course mappings section in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Course Mappings'**
  String get slots_edit_courseMappings;

  /// Prompt to select a course for slot mapping.
  ///
  /// In en, this message translates to:
  /// **'Select course'**
  String get slots_edit_selectCourse;

  /// Prompt to select a class for slot mapping.
  ///
  /// In en, this message translates to:
  /// **'Select class'**
  String get slots_edit_selectClass;

  /// Error message displayed when a slot reservation fails.
  ///
  /// In en, this message translates to:
  /// **'Failed to reserve slot'**
  String get slots_reserve_error;

  /// Label for Monday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get slots_weekday_monday;

  /// Label for Tuesday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get slots_weekday_tuesday;

  /// Label for Wednesday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get slots_weekday_wednesday;

  /// Label for Thursday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get slots_weekday_thursday;

  /// Label for Friday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get slots_weekday_friday;

  /// Label for Saturday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get slots_weekday_saturday;

  /// Label for Sunday in slot editing.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get slots_weekday_sunday;

  /// Error message displayed when the user tries to access the app on a mobile device.
  ///
  /// In en, this message translates to:
  /// **'Sorry, {appname} is currently only available on desktop devices. Please try again on a desktop device.'**
  String mobile(String appname);

  /// Error message displayed when the user navigates to a non-existent page.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we couldn\'t find the page you were looking for.'**
  String get notFound;

  /// Button label to return to the home page.
  ///
  /// In en, this message translates to:
  /// **'Return to home'**
  String get notFound_returnHome;

  /// Title for the global disclaimer message.
  ///
  /// In en, this message translates to:
  /// **'Public Beta'**
  String get global_disclaimer_title;

  /// Disclaimer message for the beta version of the app.
  ///
  /// In en, this message translates to:
  /// **'Please note that this app is currently in public **beta**. This means that there may be bugs and missing features. If you encounter any issues, please report them to us. Also, note that your faculty is still **in the process of migrating** to this new system. This means that some data may be **incomplete or incorrect**. Please **do not rely** on this app for any critical information just yet :)\n\nThank you for your understanding and support! ❤️'**
  String get global_disclaimer;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
