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

    final groups = slots.group();

    return Padding(
      padding: PaddingAll(),
      child: ListView(
        children: [
          for (final group in groups.entries)
            Column(
              children: [
                Text(
                  '${group.key.translate(context)} (${formatter.format(group.key.nextDate)})',
                  style: context.theme.textTheme.titleMedium,
                ),
                Spacing.xsVertical(),
                for (final timespan in group.value.entries)
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          Spacing.xsHorizontal(),
                          Text('${timespan.key.$1.timeOfDay} - ${timespan.key.$2.timeOfDay}'),
                        ],
                      ),
                      Wrap(
                        spacing: Spacing.mediumSpacing,
                        runSpacing: Spacing.mediumSpacing,
                        children: [for (final slot in timespan.value) SlotWidget(slot: slot, date: group.key.nextDate)],
                      ),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
