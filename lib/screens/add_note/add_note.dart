// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/screens/add_note/add_note_body.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

import '../../util/refresh.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.isEditing ,required this.note});
  final bool isEditing;
  final Note? note;

  @override
  State<AddNote> createState() => _AddNoteState();
}

final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddNoteViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (state.isChanged) {
              showConfirmationDialog(context, state);
            } else {
              context.pop();
            }
          },
          icon: const Icon(
            LineIcons.arrowLeft,
            size: 30,
          ),
        ),
        title: Text(
          "Add note ${widget.isEditing}",
          style: context.theme.textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                if (globalKey.currentState != null) {
                  if (globalKey.currentState!.validate()) {
                    if (widget.isEditing) {
                      //! note from draft doesn't exist in notes
                      //! so in NotesDB i did deal with this case
                      await crudStorage.editNote(Note(
                        id: widget.note!.id,
                        title: state.titleController.text,
                        description: state.descriptionController.text,
                        tag: state.tag,
                        createdTime: state.createdTime,
                        editedTime: DateTime.now(),
                      ));
                    } else {
                      await crudStorage.insertNote(
                        inDraft: false,
                        title: state.titleController.text,
                        description: state.descriptionController.text,
                        tag: state.tag,
                        createdTime: DateTime.now(),
                        editedTime: null,
                      );
                    }
                    
                      
                    
                    state.clearStatee();

                    if (widget.isEditing) context.pop();
                    Provider.of<Refresh>(context,listen: false).refresh();
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("make sure there is no error."),
                        dismissDirection: DismissDirection.horizontal,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(
                semanticLabel: "Save",
                LineIcons.check,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: const AddNoteBody(),
    );
  }

  Future<dynamic> showConfirmationDialog(
    BuildContext context,
    AddNoteViewModel state,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.start,
          content: Text(
            widget.isEditing
                ? "any changes that you have made will not be applied"
                : "your note will be moved to the Draft ",
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // here i am adding a new note but it's not completed yet
                if (!widget.isEditing) {
                  await crudStorage.insertNote(
                    inDraft: true,
                    title: state.titleController.text,
                    description: state.descriptionController.text,
                    tag: state.tag,
                    createdTime: state.createdTime,
                    editedTime: null,
                  );
                  state.clearStatee();
                }

                context.pop();
                context.pop();
              },
              child: Text(
                widget.isEditing ? "return anyway" : "save in draft",
                style: const TextStyle(
                  color: Color.fromRGBO(76, 175, 80, 1),
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (!widget.isEditing) context.pop();
                context.pop();
                // go to home
              },
              child: Text(
                widget.isEditing ? "stay" : "back",
                style: const TextStyle(
                  color: Color.fromRGBO(244, 67, 54, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
