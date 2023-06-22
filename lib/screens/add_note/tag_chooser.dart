import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class TagChooser extends StatefulWidget {
  const TagChooser({super.key});

  @override
  State<TagChooser> createState() => _TagChooserState();
}

class _TagChooserState extends State<TagChooser> {
  
  final List<String> tagsExplanation = [
    "daily toDos",
    "goals",
    "daily moment to keep",
    "quotes & motivations",
    "private info",
    "sth to google it later"
  ];

   
  
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddNoteViewModel>(context,listen: false);
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        value: state.tag,
        icon: const Icon(LineIcons.angleDown),
        items: tags
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: RichText(
                    text: TextSpan(
                        text: "$e ",
                        style: context.theme.textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: tagsExplanation[tags.indexOf(e)],
                            style: context.theme.textTheme.bodySmall,
                          )
                        ]),
                  ),
                ))
            .toList(),
        onChanged: (value) => setState(() {
         state.change();
          state.tag = value!;
        }),
      ),
    );
  }
}
