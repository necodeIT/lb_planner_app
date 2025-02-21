import 'dart:collection';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

/// Displays an overview of all slots for a supervisor.
class SlotOverviewScreen extends StatelessWidget {
  /// Displays an overview of all slots for a supervisor.
  const SlotOverviewScreen({super.key});

  /// The date formatter.
  static final formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    final slots = context.watch<SupervisorSlotsRepository>();

    final groups = SplayTreeMap<Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>>.from(
      slots.group(),
      (a, b) => a.nextDate.compareTo(b.nextDate),
    );

    return Padding(
      padding: PaddingAll(),
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.largeSpacing,
          children: [
            for (final group in groups.entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${group.key.translate(context)} ${formatter.format(group.key.nextDate)}',
                    style: context.theme.textTheme.titleLarge,
                  ),
                  Spacing.mediumVertical(),
                  for (final timespan in group.value.entries)
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time),
                            Spacing.xsHorizontal(),
                            Text('${timespan.key.$1.humanReadable()} - ${timespan.key.$2.humanReadable()}'),
                          ],
                        ),
                        Spacing.smallVertical(),
                        Wrap(
                          spacing: Spacing.mediumSpacing,
                          runSpacing: Spacing.mediumSpacing,
                          children: [
                            for (final slot in timespan.value)
                              SizedBox(
                                key: ValueKey(slot),
                                width: 300,
                                child: SlotOverviewWidget(slot: slot),
                              ),
                          ],
                        ).stretch(),
                      ],
                    ).paddingOnly(bottom: Spacing.largeSpacing),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
