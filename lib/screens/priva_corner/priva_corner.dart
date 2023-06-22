import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/screens/display_widget.dart';
import 'package:sync_note/theme/theme_constant.dart';
import 'package:sync_note/util/global_variable.dart';

class PrivaCorner extends StatelessWidget {
  const PrivaCorner({super.key});

  @override
  Widget build(BuildContext context) {
    List<Note> privaNotes = notes.where((note) => note.tag == "privaCorner").toList();
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
          "private notes",
          style: context.theme.textTheme.titleMedium,
        ),
      ),
      body:privaNotes.isNotEmpty? DisplayNotesWidget(
        myNotes: privaNotes
      ): Center(
              child: Text(
                "no private notes",
                style: context.theme.textTheme.titleMedium,
              ),
            ),
    );
  }
}
