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

  void createSlot(Weekday weekday) {
    showAnimatedDialog(
      context: context,
      pageBuilder: (_, __, ___) => EditSlotDialog(weekday: weekday),
    );
  }

  static const tileWidth = 350.0;
  static const tileHeight = 250.0;

  @override
  Widget buildDesktop(BuildContext context) {
    final slots = context.watch<SlotMasterSlotsRepository>();

    final groups = slots.group();

    return Padding(
      padding: PaddingAll(),
      child: SingleChildScrollView(
        child: Column(
          spacing: Spacing.largeSpacing,
          children: [
            for (final weekday in Weekday.values)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        weekday.translate(context),
                        style: context.theme.textTheme.titleMedium,
                      ),
                      Spacing.xsHorizontal(),
                      TextButton(
                        onPressed: () => createSlot(weekday),
                        child: const Text('New slot'),
                      ),
                    ],
                  ),
                  Spacing.smallVertical(),
                  if (groups[weekday]?.isNotEmpty ?? false)
                    Wrap(
                      spacing: Spacing.mediumSpacing,
                      runSpacing: Spacing.mediumSpacing,
                      children: [
                        for (final slot in (groups[weekday] ?? <Slot>[]).query(searchController.text))
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
      ),
    );
  }
}
