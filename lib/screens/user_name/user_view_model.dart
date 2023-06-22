
import 'package:flutter/material.dart';

class UserNameViewModel extends ChangeNotifier{

  TextEditingController nameController = TextEditingController();
bool doesChange = false;

 
void onChangee(){
  if (nameController.text.isNotEmpty) {
  doesChange = true;
    
  }
  notifyListeners();
}
  String? validator(String? x){
    if (x == null || x.isEmpty) {
      return "please, enetr your name.";
    }else if(x.contains(" ")){
      return "make sure it's just one word.";
    }else if(x.length > 25){
      return "too BIG";
    }
    return null;
  }
}