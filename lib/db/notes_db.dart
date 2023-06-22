import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/util/global_variable.dart';

class NotesDB {
  final String dbName;
  final int dbVersion;
  Database? _db;
  final StreamController<List<Note>> _streamController =
      StreamController.broadcast();

  NotesDB({required this.dbName, required this.dbVersion});

  //* notes..sort() will sort notes then returns it
  Stream<List<Note>> streamFunction() =>
      _streamController.stream.map((streamNotes) {
        streamNotes.sort();
        return streamNotes;
      });

  Future<bool> open() async {
    if (_db != null) {
      return true;
    } else {
      final dbDirectory = await getApplicationDocumentsDirectory();
      final path = join(dbDirectory.path, dbName);

      try {
        final db = await openDatabase(path, version: dbVersion);
        _db = db;

        const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        const textNotNull = "TEXT NOT NULL";
        const text = "TEXT";

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $notesTable (
              ${NoteFields.id} $idType,
              ${NoteFields.title} $textNotNull,
              ${NoteFields.description} $textNotNull,
              ${NoteFields.tag} $textNotNull,
              ${NoteFields.createdTime} $textNotNull,
              ${NoteFields.editedTime} $text
            );
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $draftTable (
              ${NoteFields.id} $idType,
              ${NoteFields.title} $text,
              ${NoteFields.description} $text,
              ${NoteFields.tag} $textNotNull,
              ${NoteFields.createdTime} $textNotNull,
              ${NoteFields.editedTime} $text
            );
          ''');
        log.d("opening database success");
        await fetchNotes();
        return true;
      } catch (e) {
        log.e("opening database error = $e");
        return false;
      }
    }
  }

  Future<bool> close() async {
    if (_db == null) {
      return false;
    } else {
      await _db!.close();
      return true;
    }
  }

  Future<bool> fetchNotes() async {
    if (_db == null) {
      return false;
    } else {
      try {
        final noteMaps = await _db!.query(
          notesTable,
          columns: NoteFields.values,
          distinct: true,
          orderBy: NoteFields.id,
        );
        final draftNoteMaps = await _db!.query(
          draftTable,
          columns: NoteFields.values,
          distinct: true,
          orderBy: NoteFields.id,
        );
        notes = noteMaps.map((json) => Note.fromJson(json)).toList();
        notes.sort();
        draft = draftNoteMaps.map((json) => Note.fromJson(json)).toList();
        draft.sort();
        _streamController.add(notes);
        log.d("fetching notes success length ${notes.length}");
        return true;
      } catch (e) {
        log.e("fetching notes error $e");
        return false;
      }
    }
  }

  //* this note parameter has -1 as id because
  //* id will be generated from the db automaticlly
  Future<bool> insertNote({
    required bool inDraft,
    required String title,
    required String description,
    required String tag,
    required DateTime createdTime,
    required DateTime? editedTime,
  }) async {
    if (_db == null) {
      return false;
    } else {
      try {
        final generatedID = await _db!.insert(
          inDraft ? draftTable : notesTable,
          {
            NoteFields.title: title,
            NoteFields.description: description,
            NoteFields.tag: tag,
            NoteFields.createdTime: createdTime.toIso8601String(),
            NoteFields.editedTime: editedTime?.toIso8601String(),
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        final newNote = Note(
          id: generatedID,
          title: title,
          description: description,
          tag: tag,
          createdTime: createdTime,
          editedTime: editedTime,
        );

        inDraft ? draft.insert(0, newNote) : notes.insert(0, newNote);
        _streamController.add(notes);

        inDraft
            ? log.d("add note to draft ")
            : log.d("inserting note success ");

        return true;
      } catch (e) {
        log.e("insert note error $e");
        return false;
      }
    }
  }

  Future<bool> editNote(Note editedNote) async {
    
    if (_db == null) {
      return false;
    } else {
      try {
        final updateCount = await _db!.update(
          notesTable,
          editedNote.toJson(),
          where: "${NoteFields.id} = ?",
          whereArgs: [editedNote.id],
        );
        if (updateCount == 1) {
          final index = notes.indexWhere((x) => x.id == editedNote.id);
          log.i("index $index");
          notes[index] = editedNote;
          _streamController.add(notes);
          log.d("editing note success");
          
        } else {
          // * it means that the note exist only in draft
          // * we need to create it
          log.d("editting here");
          insertNote(
            inDraft: false,
            title: editedNote.title,
            description:editedNote.description,
            tag: editedNote.tag,
            createdTime: editedNote.createdTime,
            editedTime: DateTime.now(),
          );
        }

        return true;
      } catch (e) {
        log.e("editing note error $e");
        return false;
      }
    }
  }

  Future<bool> deleteNote({required Note note,required bool fromDraft}) async {
    if (_db == null) {
      return false;
    } else {
      try {
        
        final deletedCount = await _db!.delete(
         fromDraft ? draftTable: notesTable,
          where: "${NoteFields.id} = ?",
          whereArgs: [note.id],
        );

        if (deletedCount == 1) {
       fromDraft?  draft.remove(note):   notes.remove(note);
          _streamController.add(notes);
          log.d("deleting note success deleted count $deletedCount ");
          return true;
        }
        return false;
      } catch (e) {
        log.e("deleting note error $e");
        return false;
      }
    }
  }
  Future<bool> clearDB({required bool draftt})async{
    if (_db == null) {
      return false;
    }else{
      try {
        await _db!.delete(
          draftt ? draftTable: notesTable,
        );
        draftt ? draft.clear() : notes.clear(); 
        log.d("clearing db success");

        return true;
      } catch (e) {
        log.e("clearing db error $e");
        return false;
      }
    }
  }
}
