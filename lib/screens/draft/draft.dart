import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/screens/display_widget.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class Draft extends StatelessWidget {
  const Draft({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            LineIcons.arrowLeft,
            size: 30,
          ),
        ),
        title: Text(
          "Draft",
          style: context.theme.textTheme.titleMedium,
        ),
      ),
      body: draft.isNotEmpty
          ? DisplayNotesWidget(myNotes: draft)
          : Center(
              child: Text(
                "no unfinished notes",
                style: context.theme.textTheme.titleMedium,
              ),
            ),
    );
  }
}
