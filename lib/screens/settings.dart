// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sync_note/screens/user_name/name_text_field.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';
import 'package:sync_note/util/refresh.dart';

import 'user_name/user_view_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool? isDark =
      appTheme.themeMode == ThemeMode.system ? null : appTheme.isDark;
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  //
  Future saveNewName(UserNameViewModel state, bool isCheckButton) async {
    if (key.currentState != null) {
      if (key.currentState!.validate()) {
        await localDB.setUserName(state.nameController.text);
        userName = state.nameController.text;
        state.doesChange = false;

        if (!isCheckButton) {
          context.pop();
        }
        context.pop();
      } else {
        if (!isCheckButton) context.pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("make sure there is no error."),
            dismissDirection: DismissDirection.horizontal,
          ),
        );
      }
    }
  }

  //
  //
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserNameViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (state.doesChange) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.start,
                    content:
                        const Text("do you want do save your new user name? "),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await saveNewName(state, false);
                        },
                        child: const Text(
                          "save",
                          style: TextStyle(
                            color: Color.fromRGBO(76, 175, 80, 1),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                          // context.pushNamed("Home");
                          state.doesChange = false;
                        },
                        child: const Text(
                          "cancel",
                          style: TextStyle(
                            color: Color.fromRGBO(244, 67, 54, 1),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              context.pop();
              state.doesChange = false;
            }
          },
          icon: const Icon(
            LineIcons.arrowLeft,
            size: 30,
          ),
        ),
        title: Text(
          "Settings",
          style: context.theme.textTheme.titleMedium,
        ),
        actions: [
          Consumer<UserNameViewModel>(
            builder: (context, value, child) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: value.doesChange
                  ? IconButton(
                      onPressed: () async => await saveNewName(state, true),
                      icon: const Icon(
                        semanticLabel: "Save",
                        LineIcons.check,
                        size: 30,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h, right: 20.0.w),
        child: GestureDetector(
          // onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Consumer<Refresh>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your App, Your Style",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.02),
                  RadioListTile(
                    activeColor: const Color.fromRGBO(79, 75, 189, 1),
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      "Dark",
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    value: true,
                    groupValue: isDark,
                    onChanged: (value) {
                      appTheme.useDarkLightTheme(context, isDark: true);
                      setState(() {
                        isDark = value;
                      });
                    },
                  ),
                  RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: const Color.fromRGBO(79, 75, 189, 1),
                    title: Text(
                      "Light",
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    value: false,
                    groupValue: isDark,
                    onChanged: (value) {
                      appTheme.useDarkLightTheme(context, isDark: false);
                      setState(() {
                        isDark = value;
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: const Color.fromRGBO(79, 75, 189, 1),
                    controlAffinity: ListTileControlAffinity.trailing,
                    title: Text(
                      "System default",
                      style: context.theme.textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      "We'll adjust your appearance based on your device's system settings",
                      style: context.theme.textTheme.bodySmall,
                    ),
                    value: null,
                    groupValue: isDark,
                    onChanged: (value) {
                      appTheme.useSystemTheme(context);
                      setState(() {
                        isDark = value;
                      });
                    },
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Edit user name",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w),
                    child: Text(
                      "current user name: $userName",
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: kHeight * 0.02),
                  Container(
                    width: kWidth * 0.7,
                    margin: EdgeInsets.only(left: 15.0.w),
                    child: Form(
                      key: key,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: const NameTextField(),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Clear Notes",
                    style: context.theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: kHeight * 0.02),
                  if (notes.isNotEmpty)
                    const DeleteSettings(
                      text: "home notes",
                    ),
                  SizedBox(height: kHeight * 0.02),
                  if (draft.isNotEmpty)
                    const DeleteSettings(
                      text: "draft notes",
                    ),
                  if (draft.isEmpty && notes.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(left: 15.0.w),
                      child: Text(
                        "no notes to be deleted",
                        style: context.theme.textTheme.bodyMedium,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    //
  }
  //
  //
}

class DeleteSettings extends StatelessWidget {
  const DeleteSettings({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: context.theme.textTheme.bodyMedium,
          ),
          Consumer<Refresh>(
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: () async {
                  await crudStorage.clearDB(draftt: text == "draft notes");
                  value.refresh();
                },
                child: const Text("Clear"),
              );
            },
          )
        ],
      ),
    );
  }
}
