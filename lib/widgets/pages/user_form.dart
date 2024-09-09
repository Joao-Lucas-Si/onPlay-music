import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:onPlay/models/User.dart';

class UserForm extends StatefulWidget {
  @override
  createState() => _UserfFormState();
}

class _UserfFormState extends State {
  var nameController = TextEditingController(text: "");
  UserModel? user;

  @override
  void initState() {
    super.initState();
    UserModel.colect().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: user != null
            ? Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: user!.name,
                    onChanged: (value) {
                      setState(() {
                        user!.name = value;
                        user!.save();
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
                          user!.image = image;
                          user!.save();
                        });
                      }
                    },
                    child: user!.image != null
                        ? Image.memory(user!.image!, width: 100, height: 100)
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
                          user!.save();
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
                  )
                ],
              )
            : Text("carregando"));
  }
}
