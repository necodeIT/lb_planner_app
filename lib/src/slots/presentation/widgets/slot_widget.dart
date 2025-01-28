import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/slots/slots.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A widget that displays a [SlotAggregate].
class SlotWidget extends StatefulWidget {
  /// A widget that displays a [SlotAggregate].
  const SlotWidget({super.key, required this.slot, required this.date});

  /// The slot to display.
  final Slot slot;

  ///  The date of the slot.
  final DateTime date;

  @override
  State<SlotWidget> createState() => _SlotWidgetState();
}

class _SlotWidgetState extends State<SlotWidget> {
  bool reserving = false;

  Future<void> _onTap() async {
    if (reserving) {
      return;
    }

    setState(() {
      reserving = true;
    });

    final slots = context.read<SlotsRepository>();

    try {
      await slots.book(
        date: widget.date,
        slot: widget.slot,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to reserve slot'),
          ),
        );
      }
    } finally {
      setState(() {
        reserving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<UserRepository>();
    final users = context.watch<UsersRepository>();

    var loading = false;

    final supervisors = users.state.data?.filter(ids: widget.slot.supervisors) ?? [];

    if (repo.state.hasData) {
      loading = true;
    }

    final user = repo.state.requireData;

    final mapping = widget.slot.mappings.firstWhereOrNull((m) => user.vintage != null && m.vintage == user.vintage);

    if (mapping == null) {
      loading = true;
    }

    final courses = context.watch<MoodleCoursesRepository>();

    var course = mapping?.courseId == null ? null : courses.filter(id: mapping!.courseId).firstOrNull;
    course ??= MoodleCourse.skeleton();

    return Skeletonizer(
      enabled: loading,
      child: HoverBuilder(
        onTap: widget.slot.reserved ? null : _onTap,
        builder: (context, hover) {
          final active = hover || widget.slot.reserved;

          return Container(
            decoration: BoxDecoration(
              color: active ? context.theme.primaryColor.withValues(alpha: 0.1) : context.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
              border: active
                  ? Border.all(
                      color: context.theme.primaryColor.withValues(alpha: 0.2),
                    )
                  : null,
              boxShadow: active ? kElevationToShadow[4] : null,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CourseTag(course: course!),
                    Spacing.smallHorizontal(),
                    Text(course.name).expanded(),
                    Spacing.mediumHorizontal(),
                    if (!reserving)
                      Icon(
                        active ? Icons.check_circle : Icons.circle_outlined,
                        color: active ? context.theme.primaryColor : context.theme.disabledColor,
                      ),
                    if (reserving) const CircularProgressIndicator(),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.people),
                    Spacing.smallHorizontal(),
                    Text(' ${widget.slot.reservations} / ${widget.slot.size}'),
                  ],
                ),
                Spacing.xsVertical(),
                Row(
                  children: [
                    const Icon(Icons.room),
                    Spacing.smallHorizontal(),
                    Text(widget.slot.room),
                  ],
                ),
                Spacing.xsVertical(),
                CarouselSlider(
                  disableGesture: true,
                  options: CarouselOptions(
                    autoPlay: true,
                  ),
                  items: [
                    for (final supervisor in supervisors) UserWidget(user: supervisor),
                  ],
                ).stretch(),
              ],
            ),
          );
        },
      ),
    );
  }
}
