import 'package:flutter/material.dart';

class Refresh extends ChangeNotifier{
  refresh(){
    notifyListeners();
  }
}