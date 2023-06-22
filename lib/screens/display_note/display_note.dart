// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/screens/display_note/display_note_body.dart';
import 'package:sync_note/util/count_down.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';
import 'package:sync_note/util/refresh.dart';

class DisplayNote extends StatelessWidget {
  const DisplayNote({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldMessengerState> scaffoldMesengerKey =
        GlobalKey<ScaffoldMessengerState>();
    final state = Provider.of<AddNoteViewModel>(context, listen: false);
    return Scaffold(
      key: scaffoldMesengerKey,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "from your ",
                style: context.theme.textTheme.titleMedium,
              ),
              TextSpan(
                  text: note.tag,
                  style: const TextStyle(
                      color: Color.fromRGBO(79, 75, 189, 1),
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
              TextSpan(
                text: " notes",
                style: context.theme.textTheme.titleMedium,
              ),
            ],
          ),
        ),
        // Text(
        //   "from your ${note.tag} note",
        // ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            LineIcons.arrowLeft,
            size: 30,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  // initialize the state
                  state.titleController.text = note.title;
                  state.descriptionController.text = note.description;
                  state.tag = note.tag;
                  state.createdTime = note.createdTime;
                  state.editedTime = note.editedTime;
                  // if the user edit this note i'll be able to find it
                  // with this id
                  state.id = note.id;
                  state.isChanged = false;
                  // true means is editing
                  context.pushNamed("AddNote",
                      extra: note, pathParameters: {"isEditing": "true"});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      LineIcons.editAlt,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "edit",
                      style: context.theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () async {
                  (int, bool) fromNotes =
                      (notes.indexOf(note), notes.remove(note));
                  (int, bool) fromDraft =
                      (draft.indexOf(note), draft.remove(note));

                  print(fromDraft);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          clipBehavior: Clip.antiAlias,
                          duration: const Duration(seconds: 5),
                          content: Row(
                            children: [
                              CountDown(
                                deleteFunction: () async {
                                  await crudStorage.deleteNote(
                                    note: note,
                                    fromDraft: false,
                                  );
                                  await crudStorage.deleteNote(
                                    note: note,
                                    fromDraft: true,
                                  );
                                },
                              ),
                              SizedBox(width: 20.w),
                              const Text("this note will be deleted!"),
                              const Expanded(child: SizedBox(width: 1)),
                              // here below
                              UndoButton(
                                note: note,
                                fromNotes: fromNotes,
                                fromDraft: fromDraft,
                              ),
                            ],
                          ),
                        ),
                      )
                      .closed
                      .then((value) async {
                    if (value == SnackBarClosedReason.swipe) {
                      await crudStorage.deleteNote(
                        note: note,
                        fromDraft: false,
                      );
                      await crudStorage.deleteNote(
                        note: note,
                        fromDraft: true,
                      );
                    }
                  });

                  // remove it from the data base
                  Provider.of<Refresh>(context, listen: false).refresh();
                  context.pop();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      LineIcons.trash,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "delete",
                      style: context.theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: DisplayNoteBody(note: note),
    );
  }
}

class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    required this.note,
    required this.fromNotes,
    required this.fromDraft,
  });
  final (int, bool) fromNotes;
  final (int, bool) fromDraft;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        // ScaffoldMessenger.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.swipe);
        if (fromDraft.$2) draft.insert(fromDraft.$1, note);
        if (fromNotes.$2) notes.insert(fromNotes.$1, note);
        Provider.of<Refresh>(context, listen: false).refresh();
      },
      child: Text(
        "Undo",
        style: context.theme.textTheme.labelSmall,
      ),
    );
  }
}
