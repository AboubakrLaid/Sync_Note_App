import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/screens/add_note/add_note_view_model.dart';
import 'package:sync_note/screens/display_widget.dart';
import 'package:sync_note/screens/search/search.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';
import 'package:sync_note/util/refresh.dart';

import 'components/drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int selectedTab = 0;

class _HomeState extends State<Home> {
  List<IconData?> icons = [
    LineIcons.tasks,
    LineIcons.crosshairs,
    LineIcons.userFriends,
    LineIcons.bookReader,
    LineIcons.questionCircle,
  ];

  //
  @override
  Widget build(BuildContext context) {
    return Consumer<Refresh>(
      builder: (context, value, child) => DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Builder(builder: (context) {
          return Scaffold(
            drawerEdgeDragWidth: kWidth * 0.1,
            appBar: AppBar(
              leading: Builder(builder: (context) {
                return InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(
                    Icons.menu,
                    size: 30,
                  ),
                );
              }),
              centerTitle: true,
              title: Text(
                "Home notes",
                style: context.theme.textTheme.titleMedium,
              ),
              bottom: TabBar(
                indicatorWeight: 3.0,
                isScrollable: true,
                tabs: [
                  for (var i = 0; i < 5; i++)
                    Tab(
                      height: 80,
                      text: tags[i],
                      icon: Icon(
                        icons[i],
                        size: 30,
                      ),
                    ),
                ],
                onTap: (newSelectedTab) {
                  setState(() => selectedTab = newSelectedTab);
                  DefaultTabController.of(context).animateTo(
                    newSelectedTab,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                },
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await showSearch(context: context, delegate: Search());
                    },
                    child: const Icon(
                      size: 30,
                      LineIcons.search,
                    ),
                  ),
                ),
              ],
            ),
            drawer: const MyDrawer(),
            body: (notes.isNotEmpty)
                ? TabBarView(
                    children: [
                      for (var i = 0; i < 5; i++)
                        DisplayNotesWidget(
                          myNotes: notes
                              .where((note) => note.tag == tags[i])
                              .toList(),
                        )
                    ],
                  )
                : Center(
                    child: Text(
                      "you didn't add any note yet",
                      style: context.theme.textTheme.titleMedium,
                    ),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 8,
              onPressed: () {
                final state =
                    Provider.of<AddNoteViewModel>(context, listen: false);
                state.clearStatee();
                context.pushNamed("AddNote",
                    extra: null, pathParameters: {"isEditing": "false"});
              },
              child: const Icon(
                LineIcons.plus,
                size: 30,
              ),
            ),
          );
        }),
      ),
    );
  }
}
