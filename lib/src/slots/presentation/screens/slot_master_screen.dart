import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:data_widget/data_widget.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A screen for managing slots.
class SlotMasterScreen extends StatefulWidget {
  /// A screen for managing slots.
  const SlotMasterScreen({super.key});

  @override
  State<SlotMasterScreen> createState() => _SlotMasterScreenState();
}

class _SlotMasterScreenState extends State<SlotMasterScreen> with AdaptiveState, NoMobile {
  final searchController = TextEditingController();

  Weekday activeDay = Weekday.monday;

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Data.of<TitleBarState>(context).setSearchController(searchController);
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

    final activeGroup = groups[activeDay] ?? <SlotTimeUnit, List<Slot>>{};

    return Padding(
      padding: PaddingAll(),
      child: Column(
        children: [
          Row(
            spacing: Spacing.mediumSpacing,
            children: [
              for (final weekday in Weekday.values)
                TextButton(
                  onPressed: weekday == activeDay
                      ? null
                      : () {
                          setState(() {
                            activeDay = weekday;
                          });
                        },
                  style: TextButton.styleFrom(
                    backgroundColor: weekday == activeDay ? context.theme.highlightColor : context.theme.cardColor,
                  ),
                  child: Text(
                    weekday.translate(context),
                    style: context.theme.textTheme.titleLarge,
                  ),
                ),
            ],
          ),
          Spacing.mediumVertical(),
          SingleChildScrollView(
            child: Column(
              spacing: Spacing.largeSpacing,
              children: [
                for (final timeUnit in SlotTimeUnit.values)
                  Column(
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
                            onPressed: () => createSlot(activeDay, timeUnit),
                            child: Text(context.t.slots_slotmaster_newSlot),
                          ),
                          Spacing.smallVertical(),
                        ],
                      ),
                      if (activeGroup[timeUnit]?.isNotEmpty ?? false)
                        Wrap(
                          spacing: Spacing.mediumSpacing,
                          runSpacing: Spacing.mediumSpacing,
                          children: [
                            // TODO(mastermarcohd): sort slots by roomnr
                            for (final slot in (activeGroup[timeUnit] ?? <Slot>[]).query(searchController.text))
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
          ).expanded(),
        ],
      ),
    );
  }
}
