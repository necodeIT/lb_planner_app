import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays the details of a slot created by the slot master.
class SlotMasterWidget extends StatefulWidget {
  /// Displays the details of a slot created by the slot master.
  const SlotMasterWidget({super.key, required this.slot});

  /// The slot to display.
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
      title:
          context.t.slots_slotmaster_deleteSlot_title(widget.slot.room, widget.slot.startUnit.humanReadable(), widget.slot.endUnit.humanReadable()),
      message: context.t.slots_slotmaster_deleteSlot_message,
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

  void duplicateSlot() {
    showAnimatedDialog(
      context: context,
      pageBuilder: (_, __, ___) => EditSlotDialog(slot: widget.slot, duplicate: true),
    );
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
                Text(context.t.slots_details_sizeCount(widget.slot.size)),
              ],
            ),
            Spacing.smallVertical(),
            Row(
              children: [
                const Icon(Icons.people, size: 20),
                Spacing.xsHorizontal(),
                Text(context.t.slots_details_supervisorsCount(supervisors.length)),
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
                Text(context.t.slots_details_mappingsCount(courseVintage.length)),
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
                  style: TextButton.styleFrom(foregroundColor: context.theme.colorScheme.error),
                  child: Text(context.t.global_delete),
                ),
                TextButton(
                  onPressed: isDeleting ? null : duplicateSlot,
                  child: Text(context.t.global_duplicate),
                ),
                TextButton(
                  onPressed: editSlot,
                  child: Text(context.t.global_edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
