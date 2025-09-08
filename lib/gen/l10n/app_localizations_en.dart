// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get global_confirm => 'Confirm';

  @override
  String get global_continue => 'Continue';

  @override
  String get global_create => 'Create';

  @override
  String get global_update => 'Update';

  @override
  String get global_cancel => 'Cancel';

  @override
  String get global_close => 'Close';

  @override
  String get global_search => 'Search';

  @override
  String get global_ok => 'OK';

  @override
  String get global_dismiss => 'Dismiss';

  @override
  String get global_nA => 'N/A';

  @override
  String get global_loading => 'Loading';

  @override
  String get global_edit => 'Edit';

  @override
  String get global_duplicate => 'Duplicate';

  @override
  String get global_delete => 'Delete';

  @override
  String get app_titleBar_pro => 'Pro';

  @override
  String get app_titleBar_trial => 'Trial';

  @override
  String app_update_appImage(String url) {
    return 'Download the [latest version]($url) and replace the current version with the new one.';
  }

  @override
  String get app_update_aur =>
      'Run `yay -S lb-planner` to update to the latest version.';

  @override
  String app_update_download(String url) {
    return 'Download the [latest version]($url) and install it.';
  }

  @override
  String get app_update_web =>
      'Please refresh the page with `Ctrl + Shift + F5` to update to the latest version.';

  @override
  String get app_noMobile_message =>
      'This feature is not available on mobile devices.';

  @override
  String get app_noMobile_goBack => 'Go back';

  @override
  String auth_accessHint(String appname) {
    return 'You are not allowed to use $appname. If you believe this is an error, please contact your Moodle administrator to request access.';
  }

  @override
  String get auth_username => 'Username';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_login => 'Login';

  @override
  String get auth_subtitle => 'Login with your Moodle account.';

  @override
  String get auth_invalidCredentials => 'Invalid username or password';

  @override
  String auth_version(String version) {
    return 'Version $version';
  }

  @override
  String get auth_dataCollectionConsent =>
      'I accept the collection and processing of my data as described in the ';

  @override
  String get auth_dataCollectionConsentSuffix => '.';

  @override
  String get auth_privacyPolicy => 'Privacy Policy';

  @override
  String get calendar_plan => 'Plan';

  @override
  String get calendar_tasksOverview => 'Tasks Overview';

  @override
  String get calendar_tasksOverview_description_title => 'What is this?';

  @override
  String get calendar_tasksOverview_description =>
      'The tasks overview shows the distribution of tasks over the months based on the deadlines set by the teachers.';

  @override
  String get calendar_title => 'Calendar';

  @override
  String get calendar_invite => 'Invite';

  @override
  String get calendar_leave => 'Leave Plan';

  @override
  String get calendar_leave_title => 'Leave plan?';

  @override
  String get calendar_leave_message =>
      'Are you sure you want to leave this plan? This action cannot be undone.\nBut no worries a copy of the shared plan will be saved to your account and you can be invited back at any time.';

  @override
  String get calendar_invited => 'Invited';

  @override
  String get calendar_inYourPlan => 'In your plan';

  @override
  String calendar_tasksCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tasks',
      one: '1 Task',
      zero: 'No Tasks',
    );
    return '$_temp0';
  }

  @override
  String get calendar_removeDeadline => 'Remove deadline';

  @override
  String get calendar_inviteUsers => 'Invite users';

  @override
  String get calendar_searchUsers => 'Search users';

  @override
  String get calendar_searchMembers => 'Search members';

  @override
  String get calendar_searchTasks => 'Search tasks';

  @override
  String get calendar_clearPlan => 'Clear Plan';

  @override
  String get calendar_clearPlan_title => 'Clear plan?';

  @override
  String get calendar_clearPlan_message =>
      'Are you sure you want to clear your plan? This will remove all planned tasks and cannot be undone.';

  @override
  String get calendar_tasks => 'Tasks';

  @override
  String get calendar_members => 'Members';

  @override
  String get courses_name => 'Name';

  @override
  String get courses_type => 'Type';

  @override
  String get courses_status => 'Status';

  @override
  String get courses_dueDate => 'Due date';

  @override
  String get courses_plannedDueDate => 'Planned due date';

  @override
  String get courses_overview => 'Course Overview';

  @override
  String get dashboard_todaysTasks => 'Today\'s tasks';

  @override
  String get dashboard_todaysTasks_noTasks =>
      'You\'ve nothing planned for today';

  @override
  String get dashboard_statusOverview => 'Status overview';

  @override
  String get dashboard_burnDownChart => 'Burndown chart';

  @override
  String get dashboard_burnDownChart_plannedTrajectory => 'Planned trajectory';

  @override
  String dashboard_burnDownChart_idealTrajectory(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      one: '($count task/day)',
      other: '($count tasks/day)',
    );
    return 'Ideal trajectory $_temp0';
  }

  @override
  String get dashboard_burnDownChart_explanation_title =>
      'WTF is a burndown chart?';

  @override
  String get dashboard_burnDownChart_explanation_message =>
      'The **burndown chart** helps you visualize your progress toward completing tasks.\n\n1. The **ideal trajectory** (straight line) shows how many tasks you should have left each day if you\'ve planned your tasks in an ideal way to keep a steady workload.\n2. The **planned trajectory** (curved line) shows how many tasks you\'re expected to have left based on when you\'ve planned to complete them.\n\t- Green when no tasks are remaining by the end of the semester.\n\t- Becomes red if you will not complete all modules in time.\n\nThis chart doesn’t track when tasks are actually completed—it\'s all about comparing your plan to the ideal pace so you can stay on track!\n';

  @override
  String get dashboard_exams => 'Upcoming exams';

  @override
  String get dashboard_exams_noExams => 'No exams scheduled in the near future';

  @override
  String get dashboard_title => 'Dashboard';

  @override
  String get dashboard_overdueTasks => 'Overdue tasks';

  @override
  String get dashboard_noTasksOverdue =>
      'You\'re all good, no tasks are overdue!';

  @override
  String get dashboard_slotsReservedToday => 'Slots reserved for today';

  @override
  String get dashboard_noSlotsReservedToday =>
      'You don\'t have any slots reserved for today.';

  @override
  String get enum_taskStatus_done => 'Done';

  @override
  String get enum_taskStatus_pending => 'Pending';

  @override
  String get enum_taskStatus_uploaded => 'Uploaded';

  @override
  String get enum_taskStatus_late => 'Overdue';

  @override
  String get moodle_courseSelectionScreen_selectCourses => 'Select courses';

  @override
  String get moodle_courseSelector_search => 'Search courses';

  @override
  String get moodle_moodleTaskWidget_openInMoodle => 'Open in Moodle';

  @override
  String get moodle_task_required => 'GK';

  @override
  String get moodle_task_optional => 'EK';

  @override
  String get moodle_task_exam => 'Exam';

  @override
  String get moodle_task_participation => 'M';

  @override
  String notification_newUser(String appname, String username) {
    return 'Welcome to $appname, $username! We hope you enjoy your stay.';
  }

  @override
  String notification_invite(String username) {
    return '$username invited you to join their plan!';
  }

  @override
  String get notification_invite_accept => 'Accept';

  @override
  String get notification_invite_decline => 'Decline';

  @override
  String get notification_invite_accepted => 'Accepted';

  @override
  String get notification_invite_declined => 'Declined';

  @override
  String notification_inviteAccepted(String username) {
    return '$username accepted your invitation!';
  }

  @override
  String notification_inviteDeclined(String username) {
    return '$username declined your invitation!';
  }

  @override
  String get notification_planRemoved =>
      'You have been removed from your shared plan. But don\'t worry, we\'ve got you covered - a copy of the plan has been saved to your account.';

  @override
  String notification_planLeft(String username) {
    return '$username left your plan. You can invite them back anytime.';
  }

  @override
  String notification_list_title(int count) {
    return 'Notifications ($count)';
  }

  @override
  String get notification_list_showUnread => 'Show unread';

  @override
  String get notification_list_showAll => 'Show all';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_feedback_sent_title => 'Feedback sent';

  @override
  String settings_feedback_sent_message(String sentryid) {
    return 'Thank you for your feedback. We will get back to you as soon as possible.\n\nYour feedback ID is: $sentryid';
  }

  @override
  String get settings_feedback_error_title => 'Unable to send feedback';

  @override
  String get settings_feedback_error_message =>
      'An error occurred while sending your feedback and the error has been reported to the developers. Please try again later.';

  @override
  String get settings_feedback_title => 'Feedback';

  @override
  String get settings_feedback_description => 'Please describe your problem.';

  @override
  String get settings_feedback_consent =>
      'I agree to sharing my email address and name with the developers in accordance with our ';

  @override
  String get settings_feedback_consentSuffix => '.';

  @override
  String get settings_feedback_submit => 'Submit Feedback';

  @override
  String get settings_feedback_type_bug => 'Bug';

  @override
  String get settings_feedback_type_typo => 'Typo';

  @override
  String get settings_feedback_type_feature => 'Feature';

  @override
  String get settings_feedback_type_other => 'Other';

  @override
  String get settings_general => 'General';

  @override
  String get settings_general_clearCache => 'Clear cache';

  @override
  String get settings_general_deleteProfile => 'Delete profile';

  @override
  String get settings_general_credits => 'Credits';

  @override
  String settings_general_version(String version) {
    return 'Version $version';
  }

  @override
  String get settings_general_enableEK => 'Enable EK modules';

  @override
  String get settings_general_displayTaskCount => 'Display task count';

  @override
  String get settings_general_manageSubscription => 'Manage Subscription';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_courses => 'Courses';

  @override
  String get settings_logout => 'Logout';

  @override
  String get slots_title => 'Slots';

  @override
  String slots_details_supervisorsCount(int count) {
    return 'Supervisors: $count';
  }

  @override
  String slots_details_mappingsCount(int count) {
    return 'Mappings: $count';
  }

  @override
  String slots_details_reservationsCount(int reservations, int size) {
    return 'Reservations ($reservations/$size)';
  }

  @override
  String slots_details_sizeCount(int count) {
    return 'Students: $count';
  }

  @override
  String get slots_slotmaster_newSlot => 'New slot';

  @override
  String slots_slotmaster_deleteSlot_title(
    String room,
    String startUnit,
    String endUnit,
  ) {
    return 'Delete slot $room $startUnit - $endUnit?';
  }

  @override
  String get slots_slotmaster_deleteSlot_message =>
      'Are you sure you want to delete this slot? This action cannot be undone.';

  @override
  String get slots_edit_editSlot => 'Edit slot';

  @override
  String get slots_edit_createSlot => 'Create a new slot';

  @override
  String get slots_edit_startTime => 'Start time';

  @override
  String get slots_edit_endTime => 'End time';

  @override
  String get slots_edit_weekday => 'Weekday';

  @override
  String get slots_edit_room => 'Room';

  @override
  String get slots_edit_size => 'Students';

  @override
  String get slots_edit_supervisors => 'Supervisors';

  @override
  String get slots_edit_addSupervisor => 'Add supervisor';

  @override
  String get slots_edit_courseMappings => 'Course Mappings';

  @override
  String get slots_edit_selectCourse => 'Select course';

  @override
  String get slots_edit_selectClass => 'Select class';

  @override
  String get slots_reserve_error => 'Failed to reserve slot';

  @override
  String get slots_unbook_error =>
      'An unexpected error occurred while canceling your reservation. Please try again later.';

  @override
  String get slots_weekday_monday => 'Monday';

  @override
  String get slots_weekday_tuesday => 'Tuesday';

  @override
  String get slots_weekday_wednesday => 'Wednesday';

  @override
  String get slots_weekday_thursday => 'Thursday';

  @override
  String get slots_weekday_friday => 'Friday';

  @override
  String get slots_weekday_saturday => 'Saturday';

  @override
  String get slots_weekday_sunday => 'Sunday';

  @override
  String mobile(String appname) {
    return 'Sorry, $appname is currently only available on desktop devices. Please try again on a desktop device.';
  }

  @override
  String get notFound =>
      'Sorry, we couldn\'t find the page you were looking for.';

  @override
  String get notFound_returnHome => 'Return to home';

  @override
  String get global_disclaimer_title => 'Public Beta';

  @override
  String get global_disclaimer =>
      'Please note that this app is currently in public **beta**. This means that there may be bugs and missing features. If you encounter any issues, please report them to us. Also, note that your faculty is still **in the process of migrating** to this new system. This means that some data may be **incomplete or incorrect**. Please **do not rely** on this app for any critical information just yet :)\n\nThank you for your understanding and support! ❤️';

  @override
  String kanban_card_dueOn(String dueDate) {
    return 'Due $dueDate';
  }

  @override
  String kanban_card_plannedOn(String plannedDate) {
    return 'Planned $plannedDate';
  }

  @override
  String get kanban_screen_hideBacklog => 'Hide Backlog';

  @override
  String get kanban_screen_showBacklog => 'Show Backlog';

  @override
  String get kanban_screen_backlog => 'Backlog';

  @override
  String get kanban_screen_toDo => 'To Do';

  @override
  String get kanban_screen_inProgress => 'In Progress';

  @override
  String get kanban_screen_done => 'Done';

  @override
  String get kanban_settings_kanban => 'Kanban';

  @override
  String get kanban_settings_disabled => 'Disabled';

  @override
  String get kanban_settings_moveSubmittedTasks => 'Move Submitted Tasks';

  @override
  String get kanban_settings_moveOverdueTasks => 'Move Overdue Tasks';

  @override
  String get kanban_settings_moveCompletedTasks => 'Move Completed Tasks';

  @override
  String get kanban_settings_columnColors => 'Column Colors';
}
