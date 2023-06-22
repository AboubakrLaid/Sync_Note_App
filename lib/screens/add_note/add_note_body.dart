import 'package:flutter/material.dart';
import 'package:sync_note/screens/add_note/add_note.dart';
import 'package:sync_note/screens/add_note/tag_chooser.dart';
import 'package:sync_note/screens/add_note/title_desc.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class AddNoteBody extends StatelessWidget {
  const AddNoteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: SingleChildScrollView(
            child: Form(
              key: globalKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose a tag",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.01),
                  const TagChooser(),
                  SizedBox(height: kHeight * 0.05),
                  Text(
                    "Title",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.01),
                  const TitleDescription(label: "title"),
                  SizedBox(height: kHeight * 0.05),
                  Text(
                    "Description",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.01),
                  const TitleDescription(label: "description"),
                ],
              ),
            ),
          ),
        ),
      );
  }
}