import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/slots/slots.dart';

/// A widget that displays a [SlotAggregate].
class SlotWidget extends StatefulWidget {
  /// A widget that displays a [SlotAggregate].
  const SlotWidget({super.key, required this.slot, required this.date});

  /// The slot to display.
  final SlotAggregate slot;

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
        slot: widget.slot.slot,
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
    return HoverBuilder(
      onTap: widget.slot.slot.reserved ? null : _onTap,
      builder: (context, hover) {
        final active = hover || widget.slot.slot.reserved;

        return Container(
          decoration: BoxDecoration(
            color: active ? context.theme.primaryColor.withOpacity(0.1) : context.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: active
                ? Border.all(
                    color: context.theme.primaryColor.withOpacity(0.2),
                  )
                : null,
            boxShadow: active ? kElevationToShadow[4] : null,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CourseTag(course: widget.slot.course),
                  Spacing.smallHorizontal(),
                  Text(widget.slot.course.name).expanded(),
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
                  Text(' ${widget.slot.slot.reservations} / ${widget.slot.slot.size}'),
                ],
              ),
              Spacing.xsVertical(),
              Row(
                children: [
                  const Icon(Icons.room),
                  Spacing.smallHorizontal(),
                  Text(widget.slot.slot.room),
                ],
              ),
              Spacing.xsVertical(),
              CarouselSlider(
                disableGesture: true,
                options: CarouselOptions(
                  autoPlay: true,
                ),
                items: [
                  for (final supervisor in widget.slot.supervisors)
                    Row(
                      children: [
                        UserProfileImage(
                          userId: supervisor.id,
                          size: 20,
                        ),
                        Spacing.smallHorizontal(),
                        Text(supervisor.fullname),
                      ],
                    ),
                ],
              ).stretch(),
            ],
          ),
        );
      },
    );
  }
}
