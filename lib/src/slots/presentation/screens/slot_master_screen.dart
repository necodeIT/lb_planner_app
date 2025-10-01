import 'package:awesome_extensions/awesome_extensions.dart' hide NumExtension;
import 'package:collection/collection.dart';
import 'package:data_widget/data_widget.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A screen for managing slots.
class SlotMasterScreen extends StatefulWidget {
  /// A screen for managing slots.
  const SlotMasterScreen({super.key});

  @override
  State<SlotMasterScreen> createState() => _SlotMasterScreenState();
}

class _SlotMasterScreenState extends State<SlotMasterScreen> with AdaptiveState, TickerProviderStateMixin, NoMobile {
  late final TabController _tabController;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: Weekday.values.length, vsync: this, animationDuration: 500.ms);

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Data.of<TitleBarState>(context)
      ..setSearchController(searchController)
      ..setTrailingWidget(const SlotsViewSwitcher());
  }

  void createSlot(Weekday weekday, SlotTimeUnit startUnit) {
    showAnimatedDialog(
      context: context,
      pageBuilder: (_, __, ___) => EditSlotDialog(
        weekday: weekday,
        startUnit: startUnit,
      ),
    );
  }

  static const tileWidth = 350.0;
  static const tileHeight = 250.0;

  @override
  Widget buildDesktop(BuildContext context) {
    final slots = context.watch<SlotMasterSlotsRepository>();

    final groups = slots.groupByStartUnit();

    return Padding(
      padding: PaddingAll(),
      child: Scaffold(
        appBar: TabBar(
          controller: _tabController,
          tabs: [
            for (final weekday in Weekday.values)
              Tab(
                text: weekday.translate(context),
              ),
          ],
        ),
        body: Padding(
          padding: PaddingTop(Spacing.mediumSpacing).Horizontal(Spacing.smallSpacing),
          child: TabBarView(
            controller: _tabController,
            children: [
              for (final weekday in Weekday.values) slotTimeTable(groups[weekday] ?? <SlotTimeUnit, List<Slot>>{}, weekday, slots),
            ],
          ),
        ),
      ),
    );
  }

  Widget slotTimeTable(Map<SlotTimeUnit, List<Slot>> activeGroup, Weekday weekday, SlotMasterSlotsRepository repo) {
    return SingleChildScrollView(
      child: Column(
        spacing: Spacing.largeSpacing,
        children: [
          for (final timeUnit in SlotTimeUnit.values)
            Column(
              spacing: Spacing.smallSpacing,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      timeUnit.humanReadable(),
                      style: context.theme.textTheme.titleMedium,
                    ),
                    Spacing.xsHorizontal(),
                    TextButton(
                      onPressed: () => createSlot(weekday, timeUnit),
                      child: Text(context.t.slots_slotmaster_newSlot),
                    ),
                  ],
                ),
                if (activeGroup[timeUnit]?.isNotEmpty ?? false)
                  Wrap(
                    spacing: Spacing.mediumSpacing,
                    runSpacing: Spacing.mediumSpacing,
                    children: [
                      // TODO(mastermarcohd): implement more intelligent sorting to account for building and floor.
                      for (final slot in repo.query(searchController.text, slots: activeGroup[timeUnit] ?? <Slot>[]).sortedBy((s) => s.room))
                        SizedBox(
                          key: ValueKey(slot),
                          width: tileWidth,
                          height: tileHeight,
                          child: SlotMasterWidget(slot: slot),
                        ),
                    ].show(),
                  ).stretch(),
              ],
            ),
        ],
      ),
    );
  }
}
