import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A widget that displays a [Slot].
class SlotWidget extends StatefulWidget {
  /// A widget that displays a [Slot].
  const SlotWidget({super.key, required this.slot, required this.date});

  /// The slot to display.
  final Slot slot;

  ///  The date of the slot.
  final DateTime date;

  @override
  State<SlotWidget> createState() => _SlotWidgetState();
}

class _SlotWidgetState extends State<SlotWidget> with AdaptiveState {
  bool reserving = false;

  Future<void> _onTap() async {
    if (reserving) {
      return;
    }

    setState(() {
      reserving = true;
    });

    final slots = context.read<SlotsRepository>();

    final unbook = widget.slot.reserved;

    try {
      if (unbook) {
        await slots.unbook(
          date: widget.date,
          slot: widget.slot,
        );
      } else {
        await slots.book(
          date: widget.date,
          slot: widget.slot,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(unbook ? context.t.slots_unbook_error : context.t.slots_reserve_error),
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
  Widget buildDesktop(BuildContext context) {
    final repo = context.watch<UserRepository>();
    final users = context.watch<UsersRepository>();
    final courses = context.watch<MoodleCoursesRepository>();

    var loading = false;

    final supervisors = users.state.data?.filter(ids: widget.slot.supervisors) ?? [];

    if (!repo.state.hasData) {
      loading = true;
    }

    final user = repo.state.requireData;

    final mappings = widget.slot.mappings
        .where((m) => user.vintage != null && m.vintage == user.vintage && courses.filter(id: m.courseId).isNotEmpty)
        .map((m) => courses.filter(id: m.courseId).first)
        .toList();

    if (mappings.isEmpty) {
      loading = true;
      mappings.add(MoodleCourse.skeleton());
    }

    final canBook = widget.slot.reservations < widget.slot.size &&
        !widget.slot.reserved &&
        (TimeOfDay.now().isBefore(widget.slot.startUnit.timeOfDay) || widget.date.isAfter(DateTime.now()));

    return Skeletonizer(
      enabled: loading,
      child: HoverBuilder(
        onTap: _onTap,
        builder: (context, hover) {
          hover = hover && canBook;
          final active = hover || widget.slot.reserved;

          return Container(
            padding: PaddingAll(),
            decoration: ShapeDecoration(
              color: active ? context.theme.colorScheme.primary.withValues(alpha: 0.1) : context.theme.cardColor,
              shape: squircle(
                side: active
                    ? BorderSide(
                        color: context.theme.colorScheme.primary.withValues(alpha: 0.4),
                      )
                    : BorderSide.none,
                borderAlign: BorderAlign.outside,
              ),
              shadows: active ? null : kElevationToShadow[4],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enableInfiniteScroll: false,
                        height: 40,
                        scrollDirection: Axis.vertical,
                      ),
                      items: [
                        for (final course in mappings)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CourseTag(course: course),
                              Spacing.smallHorizontal(),
                              Text(
                                course.name,
                                overflow: TextOverflow.ellipsis,
                              ).expanded(),
                            ],
                          ),
                      ],
                    ).expanded(),
                    Spacing.mediumHorizontal(),
                    if (!reserving)
                      Icon(
                        widget.slot.reserved
                            ? Icons.check_circle
                            : hover
                                ? Icons.circle
                                : Icons.circle_outlined,
                        color: active ? context.theme.colorScheme.primary : context.theme.disabledColor,
                      ),
                    if (reserving) const CircularProgressIndicator(),
                  ],
                ),
                Spacing.mediumVertical(),
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
                CarouselSlider(
                  disableGesture: true,
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    height: 40,
                    scrollDirection: Axis.vertical,
                  ),
                  items: [
                    for (final supervisor in supervisors) UserWidget(user: supervisor),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final repo = context.watch<UserRepository>();
    final users = context.watch<UsersRepository>();
    final courses = context.watch<MoodleCoursesRepository>();

    var loading = false;

    final supervisors = users.state.data?.filter(ids: widget.slot.supervisors) ?? [];

    if (!repo.state.hasData) {
      loading = true;
    }

    final user = repo.state.requireData;

    final mappings = widget.slot.mappings
        .where((m) => user.vintage != null && m.vintage == user.vintage && courses.filter(id: m.courseId).isNotEmpty)
        .map((m) => courses.filter(id: m.courseId).first)
        .toList();

    if (mappings.isEmpty) {
      loading = true;
      mappings.add(MoodleCourse.skeleton());
    }

    return Skeletonizer(
      enabled: loading,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          height: 100,
          padding: PaddingAll(),
          decoration: ShapeDecoration(
            shape: squircle(
              side: widget.slot.reserved ? BorderSide(color: context.theme.colorScheme.primary) : BorderSide.none,
              borderAlign: BorderAlign.outside,
            ),
            color: widget.slot.reserved ? context.theme.colorScheme.primary.withValues(alpha: 0.1) : context.theme.cardColor,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      height: 40,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 1,
                    ),
                    items: [
                      for (final course in mappings)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CourseTag(course: course),
                            Spacing.smallHorizontal(),
                            Text(
                              course.name,
                              overflow: TextOverflow.ellipsis,
                            ).expanded(),
                          ],
                        ),
                    ],
                  ).expanded(),
                  Spacing.xsVertical(),
                  Row(
                    spacing: Spacing.smallSpacing,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.room, size: 20),
                          Spacing.xsHorizontal(),
                          Text(widget.slot.room),
                        ],
                      ),
                      CarouselSlider(
                        disableGesture: true,
                        options: CarouselOptions(
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          height: 40,
                          scrollDirection: Axis.vertical,
                          viewportFraction: 1,
                        ),
                        items: [
                          for (final supervisor in supervisors)
                            UserWidget(
                              user: supervisor,
                              expand: true,
                            ),
                        ],
                      ).expanded(),
                    ],
                  ).expanded(),
                ],
              ).expanded(),
              Spacing.mediumHorizontal(),
              if (!reserving)
                Text(
                  '${widget.slot.reservations}/${widget.slot.size}',
                  style: TextStyle(
                    color: widget.slot.reserved ? context.theme.colorScheme.primary : context.theme.disabledColor,
                  ),
                ),
              if (reserving)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
