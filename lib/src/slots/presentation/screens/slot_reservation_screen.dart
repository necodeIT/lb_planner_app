import 'dart:collection';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// A screen for reserving slots.
class SlotReservationScreen extends StatelessWidget with AdaptiveWidget {
  /// A screen for reserving slots.
  const SlotReservationScreen({super.key});

  /// The date formatter.
  static final formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget buildDesktop(BuildContext context) {
    final slots = context.watch<SlotsRepository>();

    final groups = SplayTreeMap<Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>>.from(
      slots.group(),
      (a, b) => a.nextDate.compareTo(b.nextDate),
    );

    return Padding(
      padding: PaddingTop(),
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.largeSpacing,
          children: [
            for (final group in groups.entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: PaddingLeft(),
                    child: Text(
                      '${group.key.translate(context)} ${formatter.format(group.key.nextDate)}',
                      style: context.theme.textTheme.titleMedium,
                    ).bold(),
                  ),
                  Spacing.smallVertical(),
                  for (final timespan in group.value.entries)
                    Column(
                      children: [
                        Padding(
                          padding: PaddingLeft(),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, size: 16),
                              Spacing.xsHorizontal(),
                              Text('${timespan.key.$1.humanReadable()} - ${timespan.key.$2.humanReadable()}'),
                            ],
                          ),
                        ),
                        Spacing.smallVertical(),
                        Padding(
                          padding: PaddingLeft(),
                          child: Wrap(
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
                        ),
                      ],
                    ).paddingOnly(bottom: Spacing.largeSpacing),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final slots = context.watch<SlotsRepository>();

    final groups = SplayTreeMap<Weekday, Map<(SlotTimeUnit, SlotTimeUnit), List<Slot>>>.from(
      slots.group(),
      (a, b) => a.nextDate.compareTo(b.nextDate),
    );

    final stagger = AnimationStagger();

    return Padding(
      padding: PaddingTop(),
      child: CustomScrollView(
        slivers: [
          for (final group in groups.entries)
            SliverStickyHeader(
              header: Container(
                padding: PaddingLeft().Vertical(Spacing.smallSpacing),
                color: context.theme.scaffoldBackgroundColor,
                child: Text(
                  '${group.key.translate(context)} ${formatter.format(group.key.nextDate)}',
                  style: context.theme.textTheme.titleMedium,
                ).bold(),
              ).show(stagger),
              sliver: MultiSliver(
                children: [
                  Spacing.smallVertical(),
                  for (final timespan in group.value.entries)
                    SliverStickyHeader(
                      header: Container(
                        padding: PaddingLeft().Vertical(Spacing.smallSpacing),
                        color: context.theme.scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, size: 16),
                            Spacing.xsHorizontal(),
                            Text('${timespan.key.$1.humanReadable()} - ${timespan.key.$2.humanReadable()}'),
                          ],
                        ),
                      ).show(stagger),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Spacing.smallVertical(),
                            Padding(
                              padding: PaddingHorizontal(),
                              child: Column(
                                spacing: Spacing.smallSpacing,
                                children: [
                                  for (final slot in timespan.value)
                                    SlotWidget(key: ValueKey(slot), slot: slot, date: group.key.nextDate).stretch().show(stagger),
                                ],
                              ).stretch(),
                            ),
                          ],
                        ).paddingOnly(bottom: Spacing.largeSpacing),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ).stretch(),
    );
  }
}
