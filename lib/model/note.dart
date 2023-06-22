
String notesTable = "notes";
String draftTable = "draft";

class NoteFields {
  static const List<String> values = [
    id,
    title,
    description,
    tag,
    createdTime,
    editedTime
  ];
  static const String id = "_ID";
  static const String title = "TITLE";
  static const String description = "DESCRIPTION";
  static const String tag = "TAG";
  static const String createdTime = "CRAETED_TIME";
  static const String editedTime = "EDITED_TIME";
}

class Note implements Comparable {
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.createdTime,
    this.editedTime,
  });
  final int? id;
  final String title;
  final String description;
  final String tag;
  final DateTime createdTime;
  final DateTime? editedTime;

  Note copy({
    int? id,
    String? title,
    String? description,
    String? tag,
    DateTime? createdTime,
    DateTime? editedTime,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        tag: tag ?? this.tag,
        createdTime: createdTime ?? this.createdTime,
        editedTime: editedTime ?? this.editedTime,
      );
  
  Map<String, dynamic> toJson() => {
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.tag: tag,
        NoteFields.createdTime: createdTime.toIso8601String(),
        NoteFields.editedTime: editedTime?.toIso8601String(),
      };

  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json[NoteFields.id] as int?,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        tag: json[NoteFields.tag] as String,
        createdTime: DateTime.parse(json[NoteFields.createdTime] as String),
        editedTime: json[NoteFields.editedTime] == null
            ? null
            : DateTime.parse(json[NoteFields.editedTime] as String),
      );

  @override
  int compareTo(covariant Note other) => other.createdTime.compareTo(createdTime);

  @override
  bool operator ==(covariant Note other) => id == other.id;

  @override
  int get hashCode => id.hashCode;

  
}
