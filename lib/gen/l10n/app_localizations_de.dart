// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get global_confirm => 'Bestätigen';

  @override
  String get global_continue => 'Weiter';

  @override
  String get global_create => 'Erstellen';

  @override
  String get global_update => 'Aktualisieren';

  @override
  String get global_cancel => 'Abbrechen';

  @override
  String get global_close => 'Schließen';

  @override
  String get global_search => 'Suchen';

  @override
  String get global_ok => 'OK';

  @override
  String get global_dismiss => 'Ausblenden';

  @override
  String get global_nA => 'N/V';

  @override
  String get global_loading => 'Lädt';

  @override
  String get global_edit => 'Bearbeiten';

  @override
  String get global_delete => 'Löschen';

  @override
  String get app_titleBar_pro => 'Pro';

  @override
  String get app_titleBar_trial => 'Testversion';

  @override
  String app_update_appImage(String url) {
    return 'Lade die [neueste Version]($url) herunter und ersetze die aktuelle Version durch die neue.';
  }

  @override
  String get app_update_aur => 'Führe `yay -S lb-planner` aus, um auf die neueste Version zu aktualisieren.';

  @override
  String app_update_download(String url) {
    return 'Lade die [neueste Version]($url) herunter und installiere sie.';
  }

  @override
  String get app_update_web => 'Bitte aktualisiere die Seite mit `Strg + Shift + F5`, um auf die neueste Version zu aktualisieren.';

  @override
  String get app_noMobile_message => 'Diese Seite ist nicht auf Mobilgeräten verfügbar.';

  @override
  String get app_noMobile_goBack => 'Zurück';

  @override
  String auth_accessHint(String appname) {
    return 'Du darfst $appname nicht nutzen. Falls du glaubst, dass dies ein Fehler ist, kontaktiere bitte deinen Moodle-Administrator, um Zugang anzufordern.';
  }

  @override
  String get auth_username => 'Benutzername';

  @override
  String get auth_password => 'Passwort';

  @override
  String get auth_login => 'Anmelden';

  @override
  String get auth_subtitle => 'Melde dich mit deinem Moodle-Konto an.';

  @override
  String get auth_invalidCredentials => 'Ungültiger Benutzername oder Passwort';

  @override
  String auth_version(String version) {
    return 'Version $version';
  }

  @override
  String get auth_dataCollectionConsent => 'Ich akzeptiere die Erhebung und Verarbeitung meiner Daten wie beschrieben in der ';

  @override
  String get auth_dataCollectionConsentSuffix => '.';

  @override
  String get auth_privacyPolicy => 'Datenschutzerklärung';

  @override
  String get calendar_plan => 'Plan';

  @override
  String get calendar_tasksOverview => 'Aufgabenübersicht';

  @override
  String get calendar_tasksOverview_description_title => 'Was ist das?';

  @override
  String get calendar_tasksOverview_description => 'Die Aufgabenübersicht zeigt die Verteilung der Aufgaben über die Monate basierend auf den von den Lehrkräften gesetzten Fristen.';

  @override
  String get calendar_title => 'Kalender';

  @override
  String get calendar_invite => 'Einladen';

  @override
  String get calendar_leave => 'Plan verlassen';

  @override
  String get calendar_leave_title => 'Plan verlassen?';

  @override
  String get calendar_leave_message => 'Bist du sicher, dass du diesen Plan verlassen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.\nKeine Sorge, eine Kopie des geteilten Plans wird in deinem Konto gespeichert und du kannst jederzeit wieder eingeladen werden.';

  @override
  String get calendar_invited => 'Eingeladen';

  @override
  String get calendar_inYourPlan => 'In deinem Plan';

  @override
  String calendar_tasksCountLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Aufgaben',
      one: '1 Aufgabe',
      zero: 'Keine Aufgaben',
    );
    return '$_temp0';
  }

  @override
  String get calendar_removeDeadline => 'Frist entfernen';

  @override
  String get calendar_inviteUsers => 'Benutzer einladen';

  @override
  String get calendar_searchUsers => 'Benutzer suchen';

  @override
  String get calendar_searchMembers => 'Mitglieder suchen';

  @override
  String get calendar_searchTasks => 'Aufgaben suchen';

  @override
  String get calendar_clearPlan => 'Plan leeren';

  @override
  String get calendar_clearPlan_title => 'Plan leeren?';

  @override
  String get calendar_clearPlan_message => 'Bist du sicher, dass du deinen Plan leeren möchtest? Dadurch werden alle geplanten Aufgaben entfernt und diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get calendar_tasks => 'Aufgaben';

  @override
  String get calendar_members => 'Mitglieder';

  @override
  String get courses_name => 'Name';

  @override
  String get courses_type => 'Typ';

  @override
  String get courses_status => 'Status';

  @override
  String get courses_dueDate => 'Fälligkeitsdatum';

  @override
  String get courses_plannedDueDate => 'Geplantes Fälligkeitsdatum';

  @override
  String get courses_overview => 'Kursübersicht';

  @override
  String get dashboard_todaysTasks => 'Heutige Aufgaben';

  @override
  String get dashboard_todaysTasks_noTasks => 'Du hast für heute nichts geplant';

  @override
  String get dashboard_statusOverview => 'Statusübersicht';

  @override
  String get dashboard_burnDownChart => 'Burndown-Diagramm';

  @override
  String get dashboard_burnDownChart_plannedTrajectory => 'Geplante Entwicklung';

  @override
  String dashboard_burnDownChart_idealTrajectory(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '($count Aufgaben/Tag)',
      one: '($count Aufgabe/Tag)',
    );
    return 'Ideale Entwicklung $_temp0';
  }

  @override
  String get dashboard_burnDownChart_explanation_title => 'Was zum Teufel ist ein Burndown-Diagramm?';

  @override
  String get dashboard_burnDownChart_explanation_message => 'Das **Burndown-Diagramm** hilft dir dabei, deinen Fortschritt bei der Erledigung von Aufgaben zu visualisieren.\n\n1. Die **ideale Entwicklung** (gerade Linie) zeigt, wie viele Aufgaben du an jedem Tag übrig haben solltest, wenn du deine Aufgaben ideal geplant hast, um eine gleichmäßige Arbeitsbelastung beizubehalten.\n2. Die **geplante Entwicklung** (gekrümmte Linie) zeigt, wie viele Aufgaben basierend auf deinem geplanten Abschluss übrig sein sollten.\n\t- Grün, wenn am Ende des Semesters keine Aufgaben mehr übrig sind.\n\t- Rot, wenn du nicht alle Module rechtzeitig abschließen wirst.\n\nDieses Diagramm verfolgt nicht, wann Aufgaben tatsächlich abgeschlossen werden – es vergleicht lediglich deinen Plan mit dem idealen Tempo, damit du auf Kurs bleibst!\n';

  @override
  String get dashboard_exams => 'Bevorstehende Prüfungen';

  @override
  String get dashboard_exams_noExams => 'In naher Zukunft sind keine Prüfungen geplant';

  @override
  String get dashboard_title => 'Dashboard';

  @override
  String get dashboard_overdueTasks => 'Überfällige Aufgaben';

  @override
  String get dashboard_noTasksOverdue => 'Alles bestens, keine Aufgaben sind überfällig!';

  @override
  String get dashboard_slotsReservedToday => 'Heute reservierte Slots';

  @override
  String get dashboard_noSlotsReservedToday => 'Für heute hast du keine Slots reserviert.';

  @override
  String get enum_taskStatus_done => 'Erledigt';

  @override
  String get enum_taskStatus_pending => 'Ausstehend';

  @override
  String get enum_taskStatus_uploaded => 'Hochgeladen';

  @override
  String get enum_taskStatus_late => 'Überfällig';

  @override
  String get moodle_courseSelectionScreen_selectCourses => 'Kurse auswählen';

  @override
  String get moodle_courseSelector_search => 'Kurse suchen';

  @override
  String get moodle_moodleTaskWidget_openInMoodle => 'In Moodle öffnen';

  @override
  String get moodle_task_required => 'GK';

  @override
  String get moodle_task_optional => 'EK';

  @override
  String get moodle_task_exam => 'Prüfung';

  @override
  String get moodle_task_participation => 'M';

  @override
  String notification_newUser(String appname, String username) {
    return 'Willkommen bei $appname, $username! Wir hoffen, du genießt deinen Aufenthalt.';
  }

  @override
  String notification_invite(String username) {
    return '$username hat dich eingeladen, seinem Plan beizutreten!';
  }

  @override
  String get notification_invite_accept => 'Annehmen';

  @override
  String get notification_invite_decline => 'Ablehnen';

  @override
  String get notification_invite_accepted => 'Angenommen';

  @override
  String get notification_invite_declined => 'Abgelehnt';

  @override
  String notification_inviteAccepted(String username) {
    return '$username hat deine Einladung angenommen!';
  }

  @override
  String notification_inviteDeclined(String username) {
    return '$username hat deine Einladung abgelehnt!';
  }

  @override
  String get notification_planRemoved => 'Du wurdest aus deinem geteilten Plan entfernt. Keine Sorge, eine Kopie des Plans wurde in deinem Konto gespeichert.';

  @override
  String notification_planLeft(String username) {
    return '$username hat deinen Plan verlassen. Du kannst ihn jederzeit wieder einladen.';
  }

  @override
  String notification_list_title(int count) {
    return 'Benachrichtigungen ($count)';
  }

  @override
  String get notification_list_showUnread => 'Ungelesene anzeigen';

  @override
  String get notification_list_showAll => 'Alle anzeigen';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_feedback_sent_title => 'Feedback gesendet';

  @override
  String settings_feedback_sent_message(String sentryid) {
    return 'Vielen Dank für dein Feedback. Wir werden uns so schnell wie möglich bei dir melden.\n\nDeine Feedback-ID lautet: $sentryid';
  }

  @override
  String get settings_feedback_error_title => 'Feedback konnte nicht gesendet werden';

  @override
  String get settings_feedback_error_message => 'Beim Senden deines Feedbacks ist ein Fehler aufgetreten und der Fehler wurde den Entwicklern gemeldet. Bitte versuche es später noch einmal.';

  @override
  String get settings_feedback_title => 'Feedback';

  @override
  String get settings_feedback_description => 'Bitte beschreibe dein Problem.';

  @override
  String get settings_feedback_consent => 'Ich stimme der Weitergabe meiner E-Mail-Adresse und meines Namens an die Entwickler gemäß unserer ';

  @override
  String get settings_feedback_consentSuffix => ' zu.';

  @override
  String get settings_feedback_submit => 'Feedback absenden';

  @override
  String get settings_feedback_type_bug => 'Fehler';

  @override
  String get settings_feedback_type_typo => 'Tippfehler';

  @override
  String get settings_feedback_type_feature => 'Feature';

  @override
  String get settings_feedback_type_other => 'Andere';

  @override
  String get settings_general => 'Allgemein';

  @override
  String get settings_general_clearCache => 'Cache leeren';

  @override
  String get settings_general_deleteProfile => 'Profil löschen';

  @override
  String get settings_general_credits => 'Credits';

  @override
  String settings_general_version(String version) {
    return 'Version $version';
  }

  @override
  String get settings_general_enableEK => 'EK-Module aktivieren';

  @override
  String get settings_general_displayTaskCount => 'Anzahl der Aufgaben anzeigen';

  @override
  String get settings_general_manageSubscription => 'Abonament verwalten';

  @override
  String get settings_theme => 'Design';

  @override
  String get settings_courses => 'Kurse';

  @override
  String get settings_logout => 'Logout';

  @override
  String get slots_title => 'Slots';

  @override
  String slots_details_supervisorsCount(int count) {
    return 'Aufsichtspersonen: $count';
  }

  @override
  String slots_details_mappingsCount(int count) {
    return 'Zuordnungen: $count';
  }

  @override
  String slots_details_reservationsCount(int reservations, int size) {
    return 'Reservierungen ($reservations/$size)';
  }

  @override
  String slots_details_sizeCount(int count) {
    return 'Größe $count';
  }

  @override
  String get slots_slotmaster_newSlot => 'Neuer Slot';

  @override
  String slots_slotmaster_deleteSlot_title(String room, String startUnit, String endUnit) {
    return 'Slot $room $startUnit - $endUnit löschen?';
  }

  @override
  String get slots_slotmaster_deleteSlot_message => 'Bist du sicher, dass du diesen Slot löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get slots_edit_editSlot => 'Slot bearbeiten';

  @override
  String get slots_edit_createSlot => 'Neuen Slot erstellen';

  @override
  String get slots_edit_startTime => 'Startzeit';

  @override
  String get slots_edit_endTime => 'Endzeit';

  @override
  String get slots_edit_weekday => 'Wochentag';

  @override
  String get slots_edit_room => 'Raum';

  @override
  String get slots_edit_size => 'Größe';

  @override
  String get slots_edit_supervisors => 'Aufsichtspersonen';

  @override
  String get slots_edit_addSupervisor => 'Aufsichtsperson hinzufügen';

  @override
  String get slots_edit_courseMappings => 'Kurszuordnungen';

  @override
  String get slots_edit_selectCourse => 'Kurs auswählen';

  @override
  String get slots_edit_selectClass => 'Klasse auswählen';

  @override
  String get slots_reserve_error => 'Slot konnte nicht reserviert werden';

  @override
  String get slots_weekday_monday => 'Montag';

  @override
  String get slots_weekday_tuesday => 'Dienstag';

  @override
  String get slots_weekday_wednesday => 'Mittwoch';

  @override
  String get slots_weekday_thursday => 'Donnerstag';

  @override
  String get slots_weekday_friday => 'Freitag';

  @override
  String get slots_weekday_saturday => 'Samstag';

  @override
  String get slots_weekday_sunday => 'Sonntag';

  @override
  String mobile(String appname) {
    return 'Sorry, $appname ist derzeit nur für Desktop geräte verfügbar. Bitte öffne die App auf einem Desktop-Gerät, um fortzufahren.';
  }

  @override
  String get notFound => 'Sorry, wir konnten diese Seite nicht finden.';

  @override
  String get notFound_returnHome => 'Zurück zur Startseite';

  @override
  String get global_disclaimer_title => 'Öffentliche Beta';

  @override
  String get global_disclaimer => 'Bitte beachte, dass diese App sich derzeit in der öffentlichen **Beta** befindet.\nDas bedeutet, dass es zu Fehlern und fehlenden Funktionen kommen kann.\nWenn du auf Probleme stößt, melde sie bitte an uns.\nAußerdem beachte, dass deine Fakultät noch **im Prozess der Migration** zu diesem neuen System ist.\nDas bedeutet, dass einige Daten **unvollständig oder fehlerhaft** sein können.\nBitte **verlasse dich noch nicht** auf diese App für kritische Informationen :)\n\nVielen Dank für dein Verständnis und deine Unterstützung! ❤️';
}
