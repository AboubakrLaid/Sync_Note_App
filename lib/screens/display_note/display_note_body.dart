import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class DisplayNoteBody extends StatelessWidget {
  const DisplayNoteBody({super.key, required this.note});
  final Note note;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight * 0.02),
            const Divider(height: 2),
            SizedBox(height: kHeight * 0.02),
            SelectableText(
              note.title,
              style: context.theme.textTheme.titleLarge,
            ),
            SizedBox(height: kHeight * 0.02),
            const Divider(height: 2),
            SelectableText(
              note.description,
              style: context.theme.textTheme.bodyLarge,
            ),
            SizedBox(height: kHeight * 0.02),
            const Divider(height: 2),
            SizedBox(height: kHeight * 0.02),
            Text(
              "created on ${Jiffy.parseFromDateTime(note.createdTime).format(pattern: "d MMMM y , HH:mm:ss ")}",
              style: context.theme.textTheme.displaySmall,
            ),
            SizedBox(height: kHeight * 0.01),
            if (note.editedTime != null)
              Text(
                "edited on ${Jiffy.parseFromDateTime(note.editedTime!).format(pattern: "d MMMM y , HH:mm:ss ")}",
                style: context.theme.textTheme.displaySmall,
              ),
            SizedBox(height: kHeight * 0.02),
            const Divider(height: 2),
            Text("${note.id}"),
          ],
        ),
      ),
    );
  }
}
