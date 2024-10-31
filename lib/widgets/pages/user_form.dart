import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onPlay/models/managers/box_manager.dart';
import 'package:onPlay/models/managers/user_manager.dart';
import 'package:onPlay/models/settings/settings.dart';
import 'package:onPlay/models/user_profile.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  final bool newUser;
  const UserForm({super.key, this.newUser = false});
  @override
  createState() => _UserfFormState();
}

class _UserfFormState extends State<UserForm> {
  var nameController = TextEditingController(text: "");
  UserProfile? user;
  late UserManager userManager;

  @override
  void initState() {
    super.initState();
    final managers = Provider.of<BoxManager>(context, listen: false);
    userManager = managers.userManager;
    user =
        widget.newUser ? UserProfile(name: "") : userManager.getActiveProfile();
    if (widget.newUser) {
      user!.settings.target = DatabaseSettings(recentRange: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // leading: Center(
            //   child: IconButton(
            //       onPressed: () {
            //         final goRouter = GoRouter.of(context);
            //         goRouter.pop();
            //       },
            //       icon: const Icon(Icons.arrow_back)),
            // ),
            ),
        body: user != null
            ? Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: user!.name,
                    onChanged: (value) {
                      setState(() {
                        user!.name = value;
                        userManager.save(user!);
                      });
                    },
                    decoration: const InputDecoration(
                        labelText: "name", icon: Icon(Icons.person)),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.image);
                      if (result != null) {
                        final image = File(result.files.first.path ?? "")
                            .readAsBytesSync();
                        setState(() {
                          user!.photo = image;
                        });
                      }
                    },
                    child: user!.photo != null
                        ? Image.memory(user!.photo!, width: 100, height: 100)
                        : const Text("escolha uma image"),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await FilePicker.platform
                          .pickFiles(type: FileType.image);
                      if (result != null) {
                        final image = File(result.files.first.path ?? "")
                            .readAsBytesSync();
                        setState(() {
                          user!.banner = image;
                        });
                      }
                    },
                    child: user!.banner != null
                        ? Image.memory(
                            user!.banner!,
                            width: 100,
                            height: 100,
                          )
                        : const Text("escolha uma image"),
                  ),
                  TextButton(
                      onPressed: () {
                        userManager.save(user!);
                        GoRouter.of(context).pop(UniqueKey());
                      },
                      child: const Text(
                        "salvar",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            : const Text("carregando"));
  }
}
