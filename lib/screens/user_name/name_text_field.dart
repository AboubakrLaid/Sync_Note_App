import 'package:flutter/material.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

import 'user_view_model.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
   
  });

  

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserNameViewModel>(context, listen: false);

    return TextFormField(
      controller: state.nameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      validator: (value) => state.validator(value),
      onFieldSubmitted:(value) =>  state.onChangee(),
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: const Color.fromRGBO(79, 75, 189, 1),
    
      decoration: InputDecoration(
        label: const Text("name"),
        labelStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle:  TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: appTheme.isDark? const Color.fromRGBO(239, 242, 249, 1): const Color.fromRGBO(20, 20, 30, 1),
        ),
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