import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/screens/display_note/display_note.dart';
import 'package:sync_note/theme/theme_constant.dart';
import 'package:sync_note/util/global_variable.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key, required this.note});
  final Note note;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: context.theme.scaffoldBackgroundColor,
      closedColor: context.theme.scaffoldBackgroundColor,
      openElevation: 0,
      closedElevation: 0,
      transitionDuration: const Duration(milliseconds: 400),
      transitionType: ContainerTransitionType.fade,
      closedBuilder:(context, action) {
        return GestureDetector(
          onTap: action,
          onLongPress: () {
            
          },
          child: Column
          (mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: context.theme.primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: kHeight * 0.01),
                    Text(
                      widget.note.description,
                      maxLines: 6,
                      overflow: TextOverflow.fade,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    SizedBox(height: kHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                           Jiffy.parseFromDateTime(widget.note.createdTime).MMMd,
                          style: context.theme.textTheme.displaySmall,
                        ),
                        Text(
                          widget.note.tag,
                          style: context.theme.textTheme.labelSmall,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }, 
     openBuilder:(context, action) {
      // context.pop();
       return DisplayNote(note : widget.note);
     } ,
  
     );
  }
}
