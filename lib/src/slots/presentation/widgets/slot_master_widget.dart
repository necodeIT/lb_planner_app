import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/src/slots/slots.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SlotMasterWidget extends StatefulWidget {
  const SlotMasterWidget({super.key, required this.slot});

  final Slot slot;

  @override
  State<SlotMasterWidget> createState() => _SlotMasterWidgetState();
}

class _SlotMasterWidgetState extends State<SlotMasterWidget> {
  bool isDeleting = false;

  Future<void> deleteSlot() async {
    if (isDeleting) {
      return;
    }

    final slots = context.read<SlotMasterSlotsRepository>();

    if (!slots.state.hasData) {
      return;
    }

    final confirmed = await showConfirmationDialog(
      context,
      title: 'Delete slot ${widget.slot.room} ${widget.slot.startUnit.humanReadable()} - ${widget.slot.endUnit.humanReadable()}',
      message: 'Are you sure you want to delete this slot? This action cannot be undone.',
    );

    if (!confirmed) {
      return;
    }

    isDeleting = true;

    try {
      await slots.deleteSlot(widget.slot.id);
    } catch (e) {
      rethrow;
    } finally {
      isDeleting = false;
    }
  }

  void editSlot() {
    showAnimatedDialog(
      context: context,
      pageBuilder: (_, __, ___) => EditSlotDialog(slot: widget.slot),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UsersRepository>();

    final supervisors = users.filter(ids: widget.slot.supervisors);

    final courseRepository = context.watch<SlotMasterCoursesRepository>();

    final courseVintage = widget.slot.mappings
        .map((m) {
          final course = courseRepository.filter(id: m.courseId).firstOrNull;
          final vintage = m.vintage;

          return (course, vintage);
        })
        .where((cv) => cv.$1 != null)
        .toList();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.slot.room).bold(),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: 20),
                    Spacing.xsHorizontal(),
                    Text('${widget.slot.startUnit.humanReadable()} - ${widget.slot.endUnit.humanReadable()}'),
                  ],
                ),
              ],
            ),
            Spacing.smallVertical(),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 20),
                Spacing.xsHorizontal(),
                Text('Size: ${widget.slot.size}'),
              ],
            ),
            Spacing.smallVertical(),
            Row(
              children: [
                const Icon(Icons.people, size: 20),
                Spacing.xsHorizontal(),
                Text('Supervisors: ${supervisors.length}'),
              ],
            ),
            Padding(
              padding: PaddingLeft(Spacing.mediumSpacing),
              child: CarouselSlider(
                disableGesture: true,
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  height: 50,
                  scrollDirection: Axis.vertical,
                ),
                items: [
                  for (final supervisor in supervisors) UserWidget(user: supervisor),
                ],
              ),
            ).expanded(),
            Row(
              children: [
                const Icon(Icons.school, size: 20),
                Spacing.xsHorizontal(),
                Text('Mappings: ${courseVintage.length}'),
              ],
            ),
            Padding(
              padding: PaddingLeft(Spacing.mediumSpacing),
              child: CarouselSlider(
                disableGesture: true,
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  scrollDirection: Axis.vertical,
                  height: 50,
                ),
                items: [
                  for (final (course, vintage) in courseVintage)
                    Row(
                      children: [
                        CourseTag(course: course!),
                        Spacing.xsHorizontal(),
                        Text(course.name),
                        Spacing.smallHorizontal(),
                        Text(vintage.humanReadable),
                        Spacing.mediumHorizontal(),
                      ],
                    ),
                ],
              ),
            ).expanded(),
            // IconButton(onPressed: deleteSlot, icon: Icon(Icons.delete))
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: deleteSlot,
                  child: Text('Delete'),
                ),
                TextButton(
                  onPressed: editSlot,
                  child: Text('Edit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
