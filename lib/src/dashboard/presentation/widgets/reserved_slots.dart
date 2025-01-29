import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/src/dashboard/dashboard.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Displays the user's reserved slots for today.
class ReservedSlots extends StatefulWidget {
  /// Displays the user's reserved slots for today.
  const ReservedSlots({super.key});

  @override
  State<ReservedSlots> createState() => _ReservedSlotsState();
}

class _ReservedSlotsState extends State<ReservedSlots> {
  @override
  Widget build(BuildContext context) {
    final slots = context.watch<SlotsRepository>().getReservedSlotsForToday();
    final courses = context.watch<MoodleCoursesRepository>();
    final user = context.watch<UserRepository>();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              'Slots reserved for today',
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.mediumVertical(),
            if (slots.isEmpty || !user.state.hasData)
              ImageMessage(
                message: "You don't have any slots reserved for today.",
                image: Assets.dashboard.noReservationsForToday,
              ).expanded(),
            if (slots.isNotEmpty && user.state.hasData)
              SingleChildScrollView(
                child: Column(
                  spacing: Spacing.mediumSpacing,
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

                          final isLastUnit = slot != null && unit == slot.endUnit;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(unit.humanReadable()),
                                  Spacing.smallHorizontal(),
                                  if (slot == null)
                                    Container(
                                      height: 1,
                                      color: context.theme.dividerColor,
                                    ),
                                  if (slot != null)
                                    Row(
                                      children: [
                                        Container(
                                          height: 1,
                                          color: context.theme.dividerColor,
                                        ),
                                        Spacing.smallHorizontal(),
                                        Row(
                                          spacing: Spacing.xsSpacing,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (final course in _courses)
                                              CourseTag(
                                                course: course,
                                              ),
                                            Text(slot.room).bold(),
                                          ],
                                        ),
                                        Spacing.smallHorizontal(),
                                        Container(
                                          height: 1,
                                          color: context.theme.dividerColor,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              if (isLastUnit)
                                Row(
                                  spacing: Spacing.xsSpacing,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final course in _courses)
                                      CourseTag(
                                        course: course,
                                      ),
                                    Text(slot.room).bold(),
                                  ],
                                ),
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
}
