import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:data_widget/data_widget.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/src/slots/slots.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SlotDetailsScreen extends StatefulWidget {
  const SlotDetailsScreen({super.key, required this.slotId});

  final int slotId;

  @override
  State<SlotDetailsScreen> createState() => _SlotDetailsScreenState();
}

class _SlotDetailsScreenState extends State<SlotDetailsScreen> {
  // TODO: implement student unbooking
  void kickStudent(User student) {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Data.of<TitleBarState>(context).setParentRoute('/slots/overview/');
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UsersRepository>();

    final slots = context.watch<SupervisorSlotsRepository>();

    final slot = slots.getSlotById(widget.slotId);

    if (slot == null) {
      return const CircularProgressIndicator().center();
    }

    final supervisors = users.filter(ids: slot.supervisors);

    final courseRepository = context.watch<SlotMasterCoursesRepository>();

    final courseVintage = slot.mappings
        .map((m) {
          final course = courseRepository.filter(id: m.courseId).firstOrNull;
          final vintage = m.vintage;

          return (course, vintage);
        })
        .where((cv) => cv.$1 != null)
        .toList();

    return Padding(
      padding: PaddingAll(),
      child: FutureBuilder(
        future: slots.getSlotReservations(slot.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator().center();
          }

          final reservations = snapshot.requireData;

          final reservedStudents = users.filter(ids: reservations.map((r) => r.userId).toList());

          return Column(
            children: [
              Row(
                children: [
                  Card(
                    child: Padding(
                      padding: PaddingAll(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(slot.room, style: context.theme.textTheme.titleMedium).bold(),
                          Spacing.mediumHorizontal(),
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined, size: 16),
                              Spacing.xsHorizontal(),
                              Text('${slot.startUnit.humanReadable()} - ${slot.endUnit.humanReadable()}'),
                            ],
                          ).expanded(),
                        ],
                      ),
                    ),
                  ),
                  Spacing.mediumHorizontal(),
                  Card(
                    child: Padding(
                      padding: PaddingAll(Spacing.mediumSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Supervisors: ${supervisors.length}', style: context.theme.textTheme.titleMedium).bold(),
                          Spacing.smallVertical(),
                          Wrap(
                            spacing: Spacing.mediumSpacing,
                            runSpacing: Spacing.mediumSpacing,
                            children: [
                              for (final supervisor in supervisors) UserWidget(user: supervisor),
                            ],
                          ).stretch(),
                        ],
                      ),
                    ),
                  ).expanded(),
                  Spacing.mediumHorizontal(),
                  Card(
                    child: Padding(
                      padding: PaddingAll(Spacing.mediumSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mappings: ${courseVintage.length}', style: context.theme.textTheme.titleMedium).bold(),
                          Spacing.smallVertical(),
                          Wrap(
                            spacing: Spacing.mediumSpacing,
                            runSpacing: Spacing.mediumSpacing,
                            children: [
                              for (final (course, vintage) in courseVintage)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                          ).stretch(),
                        ],
                      ),
                    ),
                  ).expanded(),
                ],
              ).expanded(),
              Spacing.mediumVertical(),
              Card(
                child: Padding(
                  padding: PaddingAll(Spacing.mediumSpacing),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reservations (${slot.reservations}/${slot.size})', style: context.theme.textTheme.titleMedium).bold(),
                        Spacing.medium(),
                        for (final student in reservedStudents)
                          Container(
                            padding: PaddingAll(Spacing.smallSpacing),
                            decoration: ShapeDecoration(
                              shape: squircle(),
                              color: context.theme.scaffoldBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                UserWidget(
                                  user: student,
                                  size: 30,
                                ),
                                Spacing.mediumHorizontal(),
                                if (student.vintage != null) Text(student.vintage!.humanReadable),
                                // const Spacer(),
                                // IconButton(
                                //   splashColor: Colors.transparent,
                                //   highlightColor: Colors.transparent,
                                //   hoverColor: Colors.transparent,
                                //   icon: const Icon(Icons.close),
                                //   onPressed: () => kickStudent(student),
                                // ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ).expanded(flex: 6),
            ],
          );
        },
      ),
    );
  }
}
