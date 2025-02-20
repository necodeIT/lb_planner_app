import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/lb_planner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Color Picker for choosing course color.
class CourseCustomizer extends StatefulWidget {
  /// Color Picker for choosing course color.
  const CourseCustomizer({super.key, required this.course});

  /// The chosen course.
  final MoodleCourse course;

  @override
  State<CourseCustomizer> createState() => _CourseCustomizerState();
}

class _CourseCustomizerState extends State<CourseCustomizer> {
  final textController = TextEditingController();

  Color? _color;

  static const colorPresets = [
    Color(0xfff50057),
    Color(0xff536dfe),
    Color(0xfff9a826),
    Color(0xff00bfa6),
    Color(0xff9b59b6),
    Color(0xff37bbca),
    Color(0xffe67e22),
    Color(0xff37ca48),
    Color(0xffca3737),
    Color(0xffb5ca37),
    Color(0xff37ca9e),
    Color(0xff3792ca),
    Color(0xff376eca),
    Color(0xff8b37ca),
    Color(0xffca37b9),
  ];

  void changeColor(Color c) {
    setState(() {
      _color = c;
    });

    textController.text = c.toHexString(enableAlpha: false);
  }

  Future<void> saveCourseCustomization() async {
    final courses = context.watch<MoodleCoursesRepository>();

    final newCourse = widget.course.copyWith(color: _color!);

    Navigator.pop(context);

    await courses.updateCourse(newCourse);
  }

  @override
  Widget build(BuildContext context) {
    _color ??= widget.course.color;

    return GenericDialog(
      title: Row(
        children: [
          CourseTag(course: widget.course.copyWith(color: _color!)),
          Text(widget.course.name).bold(),
        ].hSpaced(Spacing.smallSpacing),
      ),
      content: ListView(
        children: [
          LayoutBuilder(
            builder: (context, size) {
              return ColorPicker(
                pickerColor: _color!,
                onColorChanged: changeColor,
                colorPickerWidth: size.maxWidth,
                pickerAreaHeightPercent: 0.4,
                enableAlpha: false,
                displayThumbColor: true,
                labelTypes: const [],
                pickerAreaBorderRadius: BorderRadius.circular(10),
                hexInputController: textController,
                portraitOnly: true,
              );
            },
          ),
          Spacing.smallVertical(),
          Wrap(
            spacing: Spacing.smallSpacing,
            runSpacing: Spacing.smallSpacing,
            children: [
              for (final color in colorPresets)
                GestureDetector(
                  onTap: () => changeColor(color),
                  child: Container(
                    decoration: ShapeDecoration(shape: squircle(), color: color),
                    width: 50,
                    height: 50,
                    child: color == _color ? Icon(Icons.check, color: context.theme.colorScheme.onPrimary) : null,
                  ),
                ),
            ],
          ),
          Spacing.largeVertical(),
          TextField(
            controller: textController,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              hintText: context.t.moodle_courseSelector_search,
              prefixIcon: Icon(
                Icons.tag,
                color: context.theme.colorScheme.onSurface,
              ),
              fillColor: context.theme.scaffoldBackgroundColor,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            autofocus: true,
            maxLength: 6,
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(
                RegExp(
                  '^[0-9a-fA-F]{1,8}',
                ),
              ),
            ],
          ).stretch(),
        ],
      ),
      actions: [
        SecondaryDialogAction(label: context.t.global_cancel, onPressed: (_) => Navigator.pop(context)),
        PrimaryDialogAction(label: context.t.global_confirm, onPressed: (_) => saveCourseCustomization()),
      ],
    );
  }
}
