import 'package:flutter/material.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class MyTitle extends StatefulWidget {
  const MyTitle({super.key});

  @override
  State<MyTitle> createState() => _MyTitleState();
}

class _MyTitleState extends State<MyTitle> with SingleTickerProviderStateMixin{
  //
  //
late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    }
    // _animationController.forward();
    // _animationController.addStatusListener((status) { 
    //   if (AnimationStatus.completed == status) {
    //     _animationController.reset();
    //   }
    // });
  }

  //
  //

  @override
  Widget build(BuildContext context) {
    
    return FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0)
                .animate(_animationController),
            child: Text(
              "Welcome, $userName",
              style: context.theme.textTheme.titleMedium,
            ),
          );
  }

  //
  //
   @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}