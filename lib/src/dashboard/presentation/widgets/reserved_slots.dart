import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/lb_planner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays the user's reserved slots for today.
class ReservedSlots extends StatefulWidget {
  /// Displays the user's reserved slots for today.
  const ReservedSlots({super.key});

  @override
  State<ReservedSlots> createState() => _ReservedSlotsState();
}

class _ReservedSlotsState extends State<ReservedSlots> with AdaptiveState {
  Widget _card(BuildContext context, {Widget? child, bool top = false, bool bottom = false}) {
    return Container(
      height: 50,
      padding: PaddingAll(Spacing.xsSpacing).Horizontal(Spacing.mediumSpacing),
      decoration: ShapeDecoration(
        color: context.theme.colorScheme.primary.withValues(alpha: 0.2),
        shape: squircle(topLeft: top, topRight: top, bottomLeft: bottom, bottomRight: bottom),
      ),
      child: child,
    ).expanded(flex: 8);
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final slots = context.watch<SlotsRepository>().getReservedSlotsForToday();
    final courses = context.watch<MoodleCoursesRepository>();
    final user = context.watch<UserRepository>();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.dashboard_slotsReservedToday,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.mediumVertical(),
            if (slots.isEmpty || !user.state.hasData)
              ImageMessage(
                message: context.t.dashboard_noSlotsReservedToday,
                image: Assets.dashboard.noReservationsForToday,
              ).expanded(),
            if (slots.isNotEmpty && user.state.hasData)
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (final unit in SlotTimeUnit.values)
                      Builder(
                        builder: (context) {
                          final slot = slots.firstWhereOrNull((s) => s.startUnit <= unit && s.endUnit > unit);

                          final _courses = slot == null
                              ? []
                              : slot.mappings
                                  .where((m) => courses.filter(id: m.courseId).isNotEmpty && m.vintage == user.state.requireData.vintage)
                                  .map((m) => courses.filter(id: m.courseId).first)
                                  .toList();

                          final isLastUnit = slots.any((s) => s.endUnit == unit.next && s == slot);
                          final isStartUnit = slot != null && slot.startUnit == unit;
                          final isInbetween = slot != null && slot.startUnit < unit && slot.endUnit > unit;

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(unit.humanReadable()),
                                  Spacing.smallHorizontal(),
                                  if (!isInbetween)
                                    Container(
                                      height: 1,
                                      color: context.theme.dividerColor,
                                    ).expanded(),
                                  if (isInbetween)
                                    Row(
                                      children: [
                                        Container(
                                          height: 1,
                                          color: context.theme.dividerColor,
                                        ).expanded(),
                                        _card(context),
                                        Container(
                                          height: 1,
                                          color: context.theme.dividerColor,
                                        ).expanded(),
                                      ],
                                    ).expanded(),
                                ],
                              ),
                              if (isStartUnit)
                                Row(
                                  children: [
                                    Text(unit.humanReadable()).setOpacity(opacity: 0), // To keep the layout consistent
                                    Spacing.smallHorizontal(),
                                    const Spacer(),
                                    _card(
                                      context,
                                      top: true,
                                      child: Row(
                                        spacing: Spacing.xsSpacing,
                                        children: [
                                          for (final course in _courses)
                                            CourseTag(
                                              course: course,
                                            ),
                                          Text(slot.room).bold(),
                                          const Spacer(),
                                          Text('${slot.startUnit.humanReadable()} - ${slot.endUnit.humanReadable()}'),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              if (isLastUnit)
                                Row(
                                  children: [
                                    Text(unit.humanReadable()).setOpacity(opacity: 0), // To keep the layout consistent
                                    Spacing.smallHorizontal(),
                                    const Spacer(),
                                    _card(context, bottom: true),
                                    const Spacer(),
                                  ],
                                ),
                              if (slot == null) Spacing.xlVertical(),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ).expanded(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final slots = context.watch<SlotsRepository>().getReservedSlotsForToday();
    final courses = context.watch<MoodleCoursesRepository>();
    final user = context.watch<UserRepository>();

    if (slots.isEmpty || !user.state.hasData) return const SizedBox.shrink();

    return Column(
      children: [
        Text(
          context.t.dashboard_slotsReservedToday,
          style: context.textTheme.titleMedium?.bold,
        ).alignAtTopLeft(),
        Spacing.mediumVertical(),
        Column(
          children: [
            for (final unit in SlotTimeUnit.values)
              Builder(
                builder: (context) {
                  final slot = slots.firstWhereOrNull((s) => s.startUnit <= unit && s.endUnit > unit);

                  final _courses = slot == null
                      ? []
                      : slot.mappings
                          .where((m) => courses.filter(id: m.courseId).isNotEmpty && m.vintage == user.state.requireData.vintage)
                          .map((m) => courses.filter(id: m.courseId).first)
                          .toList();

                  final isLastUnit = slots.any((s) => s.endUnit == unit.next && s == slot);
                  final isStartUnit = slot != null && slot.startUnit == unit;
                  final isInbetween = slot != null && slot.startUnit < unit && slot.endUnit > unit;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(unit.humanReadable()),
                          Spacing.smallHorizontal(),
                          if (!isInbetween)
                            Container(
                              height: 1,
                              color: context.theme.dividerColor,
                            ).expanded(),
                          if (isInbetween)
                            Row(
                              children: [
                                Container(
                                  height: 1,
                                  color: context.theme.dividerColor,
                                ).expanded(),
                                _card(context),
                                Container(
                                  height: 1,
                                  color: context.theme.dividerColor,
                                ).expanded(),
                              ],
                            ).expanded(),
                        ],
                      ),
                      if (isStartUnit)
                        Row(
                          children: [
                            Text(unit.humanReadable()).setOpacity(opacity: 0), // To keep the layout consistent
                            Spacing.smallHorizontal(),
                            const Spacer(),
                            _card(
                              context,
                              top: true,
                              child: Row(
                                spacing: Spacing.xsSpacing,
                                children: [
                                  for (final course in _courses)
                                    CourseTag(
                                      course: course,
                                    ),
                                  Text(slot.room).bold(),
                                  const Spacer(),
                                  Text('${slot.startUnit.humanReadable()} - ${slot.endUnit.humanReadable()}'),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      if (isLastUnit)
                        Row(
                          children: [
                            Text(unit.humanReadable()).setOpacity(opacity: 0), // To keep the layout consistent
                            Spacing.smallHorizontal(),
                            const Spacer(),
                            _card(context, bottom: true),
                            const Spacer(),
                          ],
                        ),
                      if (slot == null) Spacing.xlVertical(),
                    ],
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}
