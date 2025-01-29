import 'dart:collection';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lb_planner/lb_planner.dart';

/// A screen for reserving slots.
class SlotReservationScreen extends StatelessWidget {
  /// A screen for reserving slots.
  const SlotReservationScreen({super.key});

  /// The date formatter.
  static final formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    final slots = context.watch<SlotsRepository>();

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
                    style: context.theme.textTheme.titleMedium,
                  ).bold(),
                  Spacing.smallVertical(),
                  for (final timespan in group.value.entries)
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16),
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
                                child: SlotWidget(slot: slot, date: group.key.nextDate),
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
