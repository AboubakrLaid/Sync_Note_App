import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_note/model/note.dart';
import 'package:sync_note/screens/add_note/add_note.dart';
import 'package:sync_note/screens/draft/draft.dart';
import 'package:sync_note/screens/home/home.dart';
import 'package:sync_note/screens/on_bording/on_bording.dart';
import 'package:sync_note/screens/priva_corner/priva_corner.dart';
import 'package:sync_note/screens/settings.dart';
import 'package:sync_note/screens/user_name/user_name_page.dart';


// import '../../home/home.dart';
Widget defaultScreen = const OnBording();
final router = GoRouter(
  debugLogDiagnostics: true,
  // errorBuilder: (context, state) => ,
  routes: [
    GoRoute(
      path: '/',
      name: "root",
      builder: (context, state) =>  defaultScreen,
    ),
    GoRoute(
      path: '/OnBording',
      name: "OnBording",
      builder: (context, state) =>  const OnBording(),
    ),
    GoRoute(
      path: '/UserNamePage',
      name: "UserNamePage",
      pageBuilder: (context, state) =>  CustomTransitionPage(
        child: const UserNamePage(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: const Offset(0, 0),
            ).animate(animation),
            child: child,
          );
        },
      )
    ),
     GoRoute(
      path: '/Home',
      name: "Home",
      pageBuilder: (context, state) =>  CustomTransitionPage(
        child: const Home(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    ),
     GoRoute(
      path: '/Draft',
      name: "Draft",
      pageBuilder: (context, state) =>  CustomTransitionPage(
        child: const Draft(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    ),
     GoRoute(
      path: '/Settings',
      name: "Settings",
      pageBuilder: (context, state) =>  CustomTransitionPage(
        child: const Settings(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    ),
    GoRoute(
      path: '/AddNote/:isEditing',
      name: "AddNote",
      pageBuilder: (context, state) {
        Note?  note = state.extra == null ? null :state.extra as Note;
       
        bool isEditing= state.pathParameters["isEditing"] == "true" ? true : false ;
        return CustomTransitionPage(
        child:  AddNote(isEditing: isEditing, note: note,),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
      );
      }
    ),
    GoRoute(
      path: '/PrivaCorner',
      name: "PrivaCorner",
      pageBuilder: (context, state) =>  CustomTransitionPage(
        child: const PrivaCorner(),
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      )
    ),
  ],
);
