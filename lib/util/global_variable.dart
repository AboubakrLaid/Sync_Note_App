import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sync_note/db/local_db.dart';
import 'package:sync_note/db/notes_db.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/theme/theme.dart';

 NotesDB crudStorage = NotesDB(dbName: "notes1.db", dbVersion: 1);
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final AppTheme appTheme = AppTheme();
final LocalDB localDB = LocalDB();
final log = Logger();
final List<String> tags =[
    "taskSnap",
    "futureFocus",
    "moment",
    "quotivation",
    "memos",
    "privaCorner",
  ];
List<Note> notes = [
];
List<Note> draft = [];
String userName = "default";

final kWidth =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.width;
final kHeight =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.height;
