import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/models/settings/settings.dart';
import 'package:onPlay/models/user_profile.dart';
import 'package:onPlay/store/user_store.dart';
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
  final data = UserProfile(name: "");

  @override
  void initState() {
    super.initState();
    if (widget.newUser) {
      user!.settings.target = DatabaseSettings(recentRange: 30);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);
    user = widget.newUser ? user : userStore.user;
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
                        userStore.saveUser(user!);
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
                          userStore.saveUser(user!);
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
                  // TextButton(
                  //     onPressed: () {
                  //       userStore.saveUser(user!);
                  //       GoRouter.of(context).pop(UniqueKey());
                  //     },
                  //     child: const Text(
                  //       "salvar",
                  //       style: TextStyle(color: Colors.white),
                  //     ))
                ],
              )
            : const Text("carregando"));
  }
}
