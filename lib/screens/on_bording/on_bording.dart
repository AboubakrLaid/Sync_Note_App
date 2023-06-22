// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () => appTheme.toggleTheme(context),
      
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               SizedBox(height: kHeight * 0.1),
              
              Expanded(
                child: SizedBox(
                  
                  width: kWidth - 30,
                  child: SvgPicture.asset("images/taking_note.svg"),
                ),
              ),
             
                  
                    Text(
                  "Sync Note",
                  style: context.theme.textTheme.titleLarge,
                ),
                SizedBox(height: 40.h),
                Text(
                  "Take notes, set goals, jot down memos,keep moments, save quotes, and secure privacy",
                  style: context.theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              
               SizedBox(height: kHeight * 0.15),
            
              ElevatedButton(
                onPressed: () {
                  context.pushReplacementNamed("UserNamePage");
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 23),
                ),
              ),
               SizedBox(height: kHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
