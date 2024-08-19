import 'package:flutter/widgets.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(child: TodaysTasks()),
              SizedBox(height: 24),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(child: TasksOverview()),
              SizedBox(height: 24),
              Expanded(child: BurndownChart()),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(child: TodaysTasks()),
              SizedBox(height: 24),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
