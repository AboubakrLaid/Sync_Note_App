import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/note_widget/note_widget.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

class Search extends SearchDelegate {
  bool searchInTitle = true;
  bool searchInDescription = false;
  String result = "";
  List<Note> filtredList = [];

  _initFiltredList() {
    filtredList = notes.where((x) => x.tag != "privaCorner" ).toList()
        .where((note) => searchInTitle && searchInDescription
            ? (note.title.toLowerCase().startsWith(
                      query.toLowerCase(),
                    ) ||
                note.description.toLowerCase().startsWith(
                      query.toLowerCase(),
                    ))
            : (searchInTitle || searchInDescription)
                ? ((searchInTitle &&
                        note.title.toLowerCase().startsWith(
                              query.toLowerCase(),
                            )) ||
                    (searchInDescription &&
                        note.description.toLowerCase().startsWith(
                              query.toLowerCase(),
                            )))
                : false)
        .toList();
  }

  Widget _resultBasedOnQuery(BuildContext context) {
    // without priva corner notes
    List<Note> x = notes.where((x) => x.tag != "privaCorner" ).toList();
    return searchInTitle || searchInDescription
        ? query.isEmpty
            ? DisplayNotesForSearch(myNotes: x)
            : (filtredList.isNotEmpty
                ? DisplayNotesForSearch(myNotes: filtredList)
                : Center(
                    child: SizedBox.square(
                      dimension: 500.w,
                      child: LottieBuilder.asset("images/not_found.json"),
                    ),
                  ))
        : Center(
            child: Text(
              "Select title or description or both of them",
              style: context.theme.textTheme.bodyMedium,
            ),
          );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return context.theme.copyWith(
      useMaterial3: true,
      appBarTheme: context.theme.appBarTheme,
      indicatorColor: const Color.fromRGBO(79, 75, 189, 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appTheme.isDark
            ? const Color.fromRGBO(20, 20, 30, 1)
            : const Color.fromRGBO(239, 242, 249, 1),
        border: const OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(80)),
            borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.all(Radius.circular(80)),
            borderSide: BorderSide.none),
      ),
    );
  }

  @override
  String? get searchFieldLabel => "Search for a note";
  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 15,
        color: appTheme.isDark
            ? const Color.fromRGBO(255, 255, 255, 1)
            : const Color.fromRGBO(0, 0, 0, 1),
      );
  //
  //
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query != "")
        IconButton(
          onPressed: () => query = "",
          icon: const Icon(
            LineIcons.times,
            size: 30,
          ),
        ),
      PopupMenuButton(
        tooltip: "filter your search",
        icon: const Icon(LineIcons.filter),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () => searchInTitle = !searchInTitle,
              child: Row(
                children: [
                  Checkbox(
                    value: searchInTitle,
                    onChanged: (value) => searchInTitle = !searchInTitle,
                  ),
                  const Text("title"),
                ],
              ),
            ),
            PopupMenuItem(
              onTap: () => searchInDescription = !searchInDescription,
              child: Row(
                children: [
                  Checkbox(
                    value: searchInDescription,
                    onChanged: (value) =>
                        searchInDescription = !searchInDescription,
                  ),
                  const Text("description"),
                ],
              ),
            ),
          ];
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    _initFiltredList();

    return _resultBasedOnQuery(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _initFiltredList();
    return _resultBasedOnQuery(context);
  }
}

class DisplayNotesForSearch extends StatelessWidget {
  const DisplayNotesForSearch({super.key, required this.myNotes});
  final List<Note> myNotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.0.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0.w,
          // mainAxisSpacing: 10.0.w,
          childAspectRatio: 2 / 3.1,
        ),
        itemCount: myNotes.length,
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) => NoteWidget(note: myNotes[index]),
          );
        },
      ),
    );
  }
}
