import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SearchNoteIcon extends StatefulWidget {
  const SearchNoteIcon({super.key});

  @override
  State<SearchNoteIcon> createState() => _SearchNoteIconState();
}

class _SearchNoteIconState extends State<SearchNoteIcon> {
  Widget animatedWidget = const Text("Search");
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => switchWidget(),
    );
  }

  switchWidget() {
    if (mounted) {
      setState(() {
        animatedWidget = const Icon(
          size: 30,
          LineIcons.search,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    
     AnimatedSwitcher(
      duration: const Duration(seconds: 3),
      child: animatedWidget,
    );
  }
}
