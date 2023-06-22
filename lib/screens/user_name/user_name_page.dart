// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_note/util/export.dart';
import 'package:sync_note/util/global_variable.dart';

import 'name_text_field.dart';
import 'user_view_model.dart';

class UserNamePage extends StatefulWidget {
  const UserNamePage({super.key});

  @override
  State<UserNamePage> createState() => _UserNamePageState();
}

class _UserNamePageState extends State<UserNamePage> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserNameViewModel>(context, listen: false);

    return Scaffold(
   
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus
            ?.unfocus(), //FocusScope.of(context).unfocus(),
        

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: kHeight * 0.4,
                  width: kWidth - 30,
                  child: SvgPicture.asset("images/name.svg"),
                ),
                Text(
                  "Before we dive in! What should we call you?",
                  style: context.theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 30),
                Form(
                  key: key,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: const NameTextField(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState != null) {
                      if (key.currentState!.validate()) {
                        await localDB.setShowOnbording();
                        await localDB.setUserName(state.nameController.text);
                        userName = state.nameController.text;
                        state.onChangee();
                        context.pushReplacementNamed("Home");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("make sure there is no error."),
                            dismissDirection: DismissDirection.horizontal,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
