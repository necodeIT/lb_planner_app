import 'package:desktop/dialogs/edit_course_dialog.dart';
import 'package:desktop/widgets/views/courses_overview/course_stats/course_stats_chart.dart';
import 'package:desktop/widgets/views/dashboard/svg/catgirl.dart';
import 'package:desktop/widgets/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/data.dart';
import 'package:lb_planner/ui.dart';

class CourseOverviewItem extends StatelessWidget {
  const CourseOverviewItem(
      {Key? key, required this.id, required this.onShowDetails})
      : super(key: key);

  final int id;
  final Function(int) onShowDetails;

  @override
  Widget build(BuildContext context) {
    // var stats = DB.courses[id]!.getStats();

    double testWidth = MediaQuery.of(context).size.width;
    var stats = StatusProfile(done: 15, late: 10, uploaded: 5, pending: 20);
    var testi = 1.0;

    if (testWidth > 2100) {
      testi = 5.6;
    } else {
      if (testWidth > 1750) {
        testi = 4.5;
      } else if (testWidth > 1500) {
        testi = 3.4;
      } else {
        if (testWidth > 1000) {
          testi = 2.3;
        }
      }
    }

    return GestureDetector(
      onTap: () => onShowDetails(id),
      child: NcContainer(
        width: testWidth / testi,
        height: 250,
        label: NcCaptionText(
          "Deutsch",
          fontSize: 20,
        ),
        trailingIcon: GestureDetector(
          onTap: () => showEditCourseDialog(context, id),
          child: Icon(
            Icons.more_horiz,
            color: NcThemes.current.textColor,
          ),
        ),
        // TODO: NcTitleText(DB.courses[id]!.name),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    NcTag(
                      text: "D",

                      //TODO:text: DB.courses[id]!.tag,
                      backgroundColor: Colors.purple,
                      // TODO: Farbe von Datenbank ziehen
                    ),
                    NcSpacing.small(),
                    NcTag(
                      text: "Grade: 4",
                      // text: DB.courses[id]!.getAverageGrade().toString(),
                      backgroundColor: Colors.purple,
                      // TODO: Farbe von Datenbank ziehen
                    ),
                  ],
                ),
                NcSpacing.small(),
                // if (DB.courses[id]!.tags.contains(CourseTags.Completed)) NcTag(text: "Completed", backgroundColor: Colors.cyan),
                Row(
                  children: [
                    NcTag(
                        text: "Done",
                        backgroundColor: NcThemes.current.doneColor),
                    NcSpacing.small(),
                    //TODO: if (DB.courses[id]!.tags.contains(CourseTags.Uploaded))
                    NcTag(
                        text: "Uploaded",
                        backgroundColor: NcThemes.current.uploadedColor),
                    NcSpacing.small(),
                    NcTag(
                        text: "Late",
                        backgroundColor: NcThemes.current.lateColor),
                    NcSpacing.small(),
                    //TODO: if (DB.courses[id]!.tags.contains(CourseTags.Pending))
                    NcTag(
                        text: "Pending",
                        backgroundColor: NcThemes.current.pendingColor)
                    //TODO: if (DB.courses[id]!.tags.contains(CourseTags.Late))
                  ],
                ),
                // NcSpacing.small(),
                // Row(
                //   children: [
                //     ,
                //   ],
                // )
              ],
            ),
            // TODO: child: DB.courses[id]!.tags.contains(CourseTags.Completed) ? NcVectorImage(code: you_are_done_svg) : CourseOverviewCharts(),
            CourseStatsChart(stats: stats)
          ],
        ),

        // body: NcBodyText("test"),
      ),
    );
    // return NcButton(text: "sdasd", onTap: () {});
  }
}
