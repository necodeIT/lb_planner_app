import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays details of a slot in a compact form for a supervisor.
class SlotOverviewWidget extends StatefulWidget {
  /// Displays details of a slot in a compact form for a supervisor.
  const SlotOverviewWidget({super.key, required this.slot});

  /// The slot to display.
  final Slot slot;

  @override
  State<SlotOverviewWidget> createState() => _SlotOverviewWidgetState();
}

class _SlotOverviewWidgetState extends State<SlotOverviewWidget> {
  void showSlot() {
    Modular.to.pushNamed('/slots/overview/${widget.slot.id}');
  }

  @override
  Widget build(BuildContext context) {
    final courseRepository = context.watch<SlotMasterCoursesRepository>();

    final courseVintage = widget.slot.mappings
        .map((m) {
          final course = courseRepository.filter(id: m.courseId).firstOrNull;
          final vintage = m.vintage;

          return (course, vintage);
        })
        .where((cv) => cv.$1 != null)
        .toList();

    return HoverBuilder(
      onTap: showSlot,
      builder: (context, hover) {
        return Card(
          child: Padding(
            padding: PaddingAll(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                    const Icon(Icons.people),
                    Spacing.smallHorizontal(),
                    Text(' ${widget.slot.reservations} / ${widget.slot.size}'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.school, size: 20),
                    Spacing.xsHorizontal(),
                    Text(context.t.slots_details_mappingsCount(courseVintage.length)),
                  ],
                ),
                CarouselSlider(
                  disableGesture: true,
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    height: 40,
                    scrollDirection: Axis.vertical,
                  ),
                  items: [
                    for (final (course, vintage) in courseVintage)
                      Row(
                        children: [
                          CourseTag(course: course!),
                          Spacing.xsHorizontal(),
                          Text(
                            course.name,
                            overflow: TextOverflow.ellipsis,
                          ).expanded(flex: 3),
                          Spacing.smallHorizontal(),
                          Text(vintage.humanReadable).expanded(),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
