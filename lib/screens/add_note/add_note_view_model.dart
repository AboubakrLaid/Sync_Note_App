import 'package:flutter/material.dart';

class AddNoteViewModel extends ChangeNotifier {
  String tag = "taskSnap";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int? id = 0;
  DateTime createdTime = DateTime.now();
  DateTime? editedTime;
  // check if the user has tapped sth in title or description
  // this would be false whene editing
  bool isChanged = false;
  change() {
    isChanged = true;
  }

  clearStatee() {
    titleController.clear();
    descriptionController.clear();
    tag = "taskSnap";
    createdTime = DateTime.now();
    editedTime = null;
    isChanged = false;
    id = null;
  }

  String? validator(String? val) {
    if (val == null || val.isEmpty) {
      return "can't add empty title or description";
    }
    return null;
  }
}
