import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Month header
class CalendarTasksOverviewMonthHeader extends StatelessWidget {
  /// Month header
  const CalendarTasksOverviewMonthHeader({Key? key, required this.months}) : super(key: key);

  /// The months to display.
  final List<int> months;

  /// The width of the header.
  static const width = 40.0;

  /// Formatter for the month.
  static final formatter = DateFormat.MMM();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.theme.colorScheme.surface,
          width: width,
          height: 25,
        ),
        for (final month in months)
          Expanded(
            child: Container(
              width: width,
              color: context.theme.colorScheme.surface,
              child: Center(
                child: Text(
                  formatter.format(DateTime(0, month)).characters.join('\n').toUpperCase(),
                  style: TextStyle(
                    color: month == DateTime.now().month ? context.theme.colorScheme.primary : null,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
