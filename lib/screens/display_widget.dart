import 'package:flutter/material.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/note_widget/note_widget.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/refresh.dart';

class DisplayNotesWidget extends StatelessWidget {
  const DisplayNotesWidget({super.key, required this.myNotes});
  final List<Note> myNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
      
      child: Consumer<Refresh>(
        builder: (context, value, child) => 
       GridView.builder(
          
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0.w,
            // mainAxisSpacing: 10.0.w,
            childAspectRatio: 2/3.1,
            
            
          ),
          itemCount: myNotes.length,
          itemBuilder: (context, index) {
           
            return LayoutBuilder(builder: (context, constraints) =>  NoteWidget(note: myNotes[index]),);
          },
        ),
      ),
    );
  }
}