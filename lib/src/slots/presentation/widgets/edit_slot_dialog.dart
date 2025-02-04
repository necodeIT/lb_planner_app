import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A dialog for editing or creating a slot.
/// Edits a slot if [slot] is provided and creates a new slot if [weekday] is provided.
class EditSlotDialog extends StatefulWidget {
  /// A dialog for editing or creating a slot.
  /// Edits a slot if [slot] is provided and creates a new slot if [weekday] is provided.
  const EditSlotDialog({super.key, this.slot, this.weekday}) : assert(slot != null || weekday != null, 'Either slot or weekday must be provided');

  /// The weekday the slot will be created for.
  final Weekday? weekday;

  /// The slot to edit.
  final Slot? slot;

  @override
  State<EditSlotDialog> createState() => _EditSlotDialogState();
}

class _EditSlotDialogState extends State<EditSlotDialog> {
  final supervisorController = TextEditingController();
  final roomController = TextEditingController();
  final courseController = TextEditingController();
  final vintageController = TextEditingController();
  final roomFocusNode = FocusNode();

  Weekday? weekday;

  late final bool editing;

  SlotTimeUnit? start;
  SlotTimeUnit? end;

  int? size;

  List<int> supervisors = [];
  List<CourseToSlot> mappings = [];

  bool submitting = false;

  @override
  void initState() {
    super.initState();

    editing = widget.slot != null;

    weekday = widget.slot?.weekday ?? widget.weekday;

    roomController.text = widget.slot?.room ?? '';

    start = widget.slot?.startUnit;
    end = widget.slot?.endUnit;

    supervisors = List.of(widget.slot?.supervisors ?? []);
    size = widget.slot?.size ?? 1;
    mappings = List.of(widget.slot?.mappings ?? []);

    if (widget.slot != null) {
      roomController.text = widget.slot!.room;
    }

    roomController.addListener(() {
      setState(() {});
    });
  }

  bool get canSubmit =>
      start != null &&
      end != null &&
      weekday != null &&
      size != null &&
      roomController.text.isNotEmpty &&
      supervisors.isNotEmpty &&
      mappings.isNotEmpty;

  void setSize(int value) {
    setState(() {
      size = value;
    });
  }

  Future<void> createSlot() async {
    if (!canSubmit || submitting) return;

    setState(() {
      submitting = true;
    });

    final repo = context.read<SlotMasterSlotsRepository>();

    final slot = widget.slot?.copyWith(
          room: roomController.text,
          startUnit: start!,
          duration: end!.difference(start!),
          weekday: weekday!,
          supervisors: supervisors,
          size: size!,
          mappings: mappings,
        ) ??
        Slot(
          id: -1,
          room: roomController.text,
          startUnit: start!,
          duration: end!.difference(start!),
          weekday: weekday!,
          supervisors: supervisors,
          size: size!,
          reservations: -1,
          reserved: false,
          mappings: mappings,
        );

    if (editing) {
      await repo.updateSlot(slot);
    } else {
      await repo.createSlot(slot);
    }

    if (mounted) {
      setState(() {
        submitting = false;
      });

      Navigator.pop(context);
    }
  }

  void setStart(SlotTimeUnit? time) {
    if (time == null) return;

    setState(() {
      start = time;

      if (end == null || end! <= time) {
        end = time + 1;
      }
    });
  }

  void setEnd(SlotTimeUnit? time) {
    if (time == null) return;

    setState(() {
      end = time;

      if (start == null || start! >= time) {
        start = time - 1;
      }
    });
  }

  void setWeekday(Weekday? day) {
    if (day == null) return;

    setState(() {
      weekday = day;
    });
  }

  void addSupervisor(int? id) {
    if (id == null) return;

    setState(() {
      supervisorController.clear();
      supervisors.add(id);
    });
  }

  void removeSupervisor(int id) {
    setState(() {
      supervisors.remove(id);
    });
  }

  void addMapping(int courseId, Vintage vintage) {
    setState(() {
      final mapping = CourseToSlot.noId(courseId: courseId, slotId: widget.slot?.id ?? -1, vintage: vintage);

      mappings.add(mapping);

      courseController.clear();
      vintageController.clear();
    });
  }

  void removeMapping(int courseId, Vintage vintage) {
    setState(() {
      mappings.removeWhere((mapping) => mapping.courseId == courseId && mapping.vintage == vintage);
    });
  }

  Vintage? vintage;
  MoodleCourse? course;

  void setCourse(MoodleCourse? course) {
    setState(() {
      this.course = course;
    });
  }

  void setVintage(Vintage? vintage) {
    setState(() {
      this.vintage = vintage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UsersRepository>();
    final slots = context.watch<SlotMasterSlotsRepository>();

    final supervisors = this.supervisors.isEmpty ? const Iterable.empty() : users.filter(ids: this.supervisors);
    final potentialSupervisors = users.filter(capability: UserCapability.teacher).where((user) => !this.supervisors.contains(user.id));
    final rooms = slots.state.data?.map((slot) => slot.room).toSet() ?? const Iterable<String>.empty();

    final courses = context.watch<SlotMasterCoursesRepository>();
    final courseMappings = mappings.map((m) => (courses.filter(id: m.courseId).firstOrNull, m.vintage)).toList();

    return GenericDialog(
      shrinkWrap: false,
      title: Text(editing ? context.t.slots_edit_editSlot : context.t.slots_edit_createSlot),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (submitting) const LinearProgressIndicator(),
          Row(
            spacing: Spacing.mediumSpacing,
            children: [
              LayoutBuilder(
                builder: (context, size) {
                  return DropdownMenu<SlotTimeUnit>(
                    onSelected: setStart,
                    enabled: !submitting,
                    initialSelection: start,
                    leadingIcon: const Icon(Icons.timer_outlined),
                    width: size.maxWidth,
                    hintText: context.t.slots_edit_startTime,
                    helperText: context.t.slots_edit_startTime,
                    menuHeight: 200,
                    trailingIcon: const Icon(
                      FontAwesome5Solid.chevron_down,
                      size: 13,
                    ),
                    requestFocusOnTap: false, // disable text input
                    dropdownMenuEntries: SlotTimeUnit.values.where((u) => u < SlotTimeUnit.values.last).map((time) {
                      return DropdownMenuEntry(
                        label: time.humanReadable(),
                        value: time,
                        leadingIcon: const Icon(Icons.timer_outlined, size: 15),
                      );
                    }).toList(),
                  );
                },
              ).expanded(),
              LayoutBuilder(
                builder: (context, size) {
                  return DropdownMenu<SlotTimeUnit>(
                    onSelected: setEnd,
                    width: size.maxWidth,
                    menuHeight: 200,
                    enabled: !submitting,

                    helperText: context.t.slots_edit_endTime,
                    hintText: context.t.slots_edit_endTime,
                    leadingIcon: const Icon(Icons.timer_off_outlined),

                    trailingIcon: const Icon(
                      FontAwesome5Solid.chevron_down,
                      size: 13,
                    ),
                    initialSelection: end, requestFocusOnTap: false, // disable text input

                    dropdownMenuEntries: SlotTimeUnit.values.where((u) => u > (start ?? SlotTimeUnit.$1)).map((time) {
                      return DropdownMenuEntry(
                        label: time.humanReadable(),
                        value: time,
                        leadingIcon: const Icon(Icons.timer_off_outlined, size: 15),
                      );
                    }).toList(),
                  );
                },
              ).expanded(),
              LayoutBuilder(
                builder: (context, size) {
                  return DropdownMenu<Weekday>(
                    onSelected: setWeekday,
                    menuHeight: 200,
                    hintText: context.t.slots_edit_weekday, width: size.maxWidth,
                    helperText: context.t.slots_edit_weekday,
                    enabled: !submitting,

                    leadingIcon: const Icon(FontAwesome.calendar_check_o),
                    trailingIcon: const Icon(
                      FontAwesome5Solid.chevron_down,
                      size: 13,
                    ),
                    initialSelection: weekday,
                    requestFocusOnTap: false, // disable text input
                    dropdownMenuEntries: Weekday.values.map((weekday) {
                      return DropdownMenuEntry(
                        label: weekday.translate(context),
                        value: weekday,
                        leadingIcon: const Icon(FontAwesome.calendar_check_o),
                      );
                    }).toList(),
                  );
                },
              ).expanded(),
              LayoutBuilder(
                builder: (context, size) {
                  return RawAutocomplete<String>(
                    focusNode: roomFocusNode,
                    textEditingController: roomController,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }

                      return rooms.where((String option) {
                        return option.containsIgnoreCase(textEditingValue.text);
                      });
                    },
                    onSelected: (String value) {
                      roomController.text = value;
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: size.maxWidth,
                          child: Card(
                            elevation: 8,
                            color: context.theme.scaffoldBackgroundColor,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (final option in options)
                                  MenuItemButton(
                                    child: Text(option),
                                    onPressed: () => onSelected(option),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    fieldViewBuilder: (context, controller, focusNode, callback) {
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        inputFormatters: [UpperCaseTextFormatter()],
                        maxLength: 7,
                        enabled: !submitting,
                        decoration: InputDecoration(
                          hintText: context.t.slots_edit_room,
                          helperText: context.t.slots_edit_room,
                          prefixIcon: const Icon(Icons.room),
                        ),
                      );
                    },
                  );
                },
              ).expanded(),
              NumberSpinner<int>(
                decoration: InputDecoration(
                  hintText: context.t.slots_edit_size,
                  helperText: context.t.slots_edit_size,
                ),
                initialValue: size,
                onChanged: setSize,
                min: 1,
                enabled: !submitting,
              ).expanded(),
            ],
          ).stretch(),
          Spacing.largeVertical(),
          Text(
            context.t.slots_edit_supervisors,
            style: context.theme.textTheme.titleMedium,
          ),
          Spacing.smallVertical(),
          LayoutBuilder(
            builder: (context, size) {
              return DropdownMenu<int>(
                onSelected: addSupervisor,
                enabled: !submitting,
                filterCallback: (ids, query) => ids.where((id) => id.label.containsIgnoreCase(query)).toList(),
                controller: supervisorController,
                menuHeight: 200,
                enableSearch: false,
                enableFilter: true,
                hintText: context.t.slots_edit_addSupervisor,
                width: size.maxWidth,
                leadingIcon: const Icon(
                  Icons.person,
                ),
                trailingIcon: const Icon(
                  FontAwesome5Solid.chevron_down,
                  size: 13,
                ),
                dropdownMenuEntries: [
                  for (final supervisor in potentialSupervisors)
                    DropdownMenuEntry(
                      value: supervisor.id,
                      label: supervisor.fullname,
                      leadingIcon: const Icon(Icons.person),
                      //leadingIcon: UserProfileImage(userId: supervisor.id, size: 30),
                    ),
                ],
              );
            },
          ),
          Spacing.mediumVertical(),
          ListView(
            shrinkWrap: true,
            children: [
              for (final supervisor in supervisors)
                Container(
                  padding: PaddingAll(Spacing.smallSpacing),
                  decoration: ShapeDecoration(
                    shape: squircle(),
                    color: context.theme.scaffoldBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UserWidget(
                        user: supervisor,
                        size: 30,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        icon: const Icon(Icons.close),
                        onPressed: () => removeSupervisor(supervisor.id),
                      ),
                    ],
                  ),
                ),
            ].vSpaced(Spacing.smallSpacing),
          ).expanded(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.slots_edit_courseMappings,
                style: context.theme.textTheme.titleMedium,
              ),
              Spacing.smallVertical(),
              Row(
                spacing: Spacing.mediumSpacing,
                children: [
                  LayoutBuilder(
                    builder: (context, size) {
                      return DropdownMenu<MoodleCourse>(
                        initialSelection: course,
                        onSelected: setCourse,
                        enabled: !submitting,
                        trailingIcon: const Icon(
                          FontAwesome5Solid.chevron_down,
                          size: 13,
                        ),
                        controller: courseController,
                        leadingIcon: const Icon(Icons.book),
                        width: size.maxWidth,
                        filterCallback: (entries, filter) => entries.where((entry) => entry.label.containsIgnoreCase(filter)).toList(),
                        enableSearch: false,
                        enableFilter: true,
                        hintText: context.t.slots_edit_selectCourse,
                        menuHeight: 200,
                        dropdownMenuEntries: [
                          for (final course in courses.filter())
                            DropdownMenuEntry(
                              value: course,
                              label: course.name,
                              leadingIcon: CourseTag(course: course),
                            ),
                        ],
                      );
                    },
                  ).expanded(),
                  LayoutBuilder(
                    builder: (context, size) {
                      return DropdownMenu<Vintage>(
                        width: size.maxWidth,
                        enabled: !submitting,
                        trailingIcon: const Icon(
                          FontAwesome5Solid.chevron_down,
                          size: 13,
                        ),
                        initialSelection: vintage,
                        hintText: context.t.slots_edit_selectClass,
                        leadingIcon: const Icon(Icons.school),
                        menuHeight: 200,
                        onSelected: setVintage,
                        controller: vintageController,
                        filterCallback: (entries, filter) => entries.where((entry) => entry.label.containsIgnoreCase(filter)).toList(),
                        enableFilter: true,
                        dropdownMenuEntries: [
                          for (final vintage in Vintage.values.where((v) => v.suffix.isNotEmpty))
                            DropdownMenuEntry(
                              value: vintage,
                              label: vintage.humanReadable,
                              leadingIcon: const Icon(Icons.school),
                            ),
                        ],
                      );
                    },
                  ).expanded(),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: course == null || vintage == null || submitting
                        ? null
                        : () {
                            addMapping(course!.id, vintage!);
                            setCourse(null);
                            setVintage(null);
                          },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Spacing.mediumVertical(),
              ListView(
                children: [
                  for (final (course, vintage) in courseMappings)
                    Container(
                      padding: PaddingAll(Spacing.smallSpacing),
                      decoration: ShapeDecoration(
                        shape: squircle(),
                        color: context.theme.scaffoldBackgroundColor,
                      ),
                      child: Row(
                        children: [
                          CourseTag(course: course!),
                          Spacing.smallHorizontal(),
                          Text(course.name),
                          Spacing.smallHorizontal(),
                          Text(vintage.humanReadable),
                          const Spacer(),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            onPressed: () => removeMapping(course.id, vintage),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                ].vSpaced(Spacing.smallSpacing),
              ).expanded(),
            ],
          ).expanded(),
        ],
      ),
      actions: [
        SecondaryDialogAction(
          label: context.t.global_cancel,
          onPressed: submitting ? null : Navigator.pop,
        ),
        PrimaryDialogAction(
          label: editing ? context.t.global_update : context.t.global_create,
          onPressed: canSubmit && !submitting ? (_) => createSlot() : null,
        ),
      ],
    );
  }
}
