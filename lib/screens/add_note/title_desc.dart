import 'package:flutter/material.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/util/export.dart';

import '../../util/global_variable.dart';

class TitleDescription extends StatelessWidget {
  const TitleDescription({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AddNoteViewModel>(context,listen: false);
    return TextFormField(
      controller: label == "title" ? state.titleController : state.descriptionController,
      keyboardType:TextInputType.multiline ,
      //  textInputAction:label=="title"? TextInputAction.next: TextInputAction.done,
        maxLines: label == "title" ? 2 :10 ,
     
     
      // expands:label == "title"?false: true,
      validator: (value) => state.validator(value),
      onChanged: (value) => state.change(),
      // onFieldSubmitted:(value) =>  state.onChangee(),
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: const Color.fromRGBO(79, 75, 189, 1),
    
      decoration: InputDecoration(
       
        errorStyle: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(244, 67, 54, 1),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:  BorderSide(
          color: appTheme.isDark? const Color.fromRGBO(239, 242, 249, 1): const Color.fromRGBO(20, 20, 30, 1),
           
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:  BorderSide(
          color: appTheme.isDark? const Color.fromRGBO(239, 242, 249, 1): const Color.fromRGBO(20, 20, 30, 1),
          
           
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:  const BorderSide(
            color: Color.fromRGBO(244, 67, 54, 1),
           
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:  BorderSide(
          color: appTheme.isDark? const Color.fromRGBO(239, 242, 249, 1): const Color.fromRGBO(20, 20, 30, 1),
           
            width: 2.0,
          ),
        ),
      ),
    );
  }
}