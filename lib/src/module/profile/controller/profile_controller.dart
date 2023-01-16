import 'dart:io';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/shared/utils/info_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/utils/validator.dart';

class ProfileController extends State<ProfileView> {
  static late ProfileController instance;
  late ProfileView view;
  late TextEditingController userController;
  File? image;

  @override
  void initState() {
    instance = this;
    userController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  signOut(BuildContext context) async {
    await infoDialog(
        title: "Are you sure to logout ?",
        onContinue: () async {
          await AuthService.doLogout();
          Get.offAll(const LoginView());
        });
  }

  void editUserName({
    required BuildContext context,
    required String name,
  }) async {
    if (name.isEmpty || name == " ") return;
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            autofocus: true,
            initialValue: name,
            validator: Validator.required,
            onChanged: (value) {
              name = value;
              setState(() {});
            },
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(userController.text);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        );
      },
    );
    await UserService.instance.editUserName(name);
  }

  Future _pickedImage() async {
    final XFile? imageGalery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageGalery == null) return;
    image = File(imageGalery.path);
  }

  void editUserPhoto() async {
    await _pickedImage();
    String urlImage =
        await UserService.instance.uploadImage(image!, rootChild: "profile");
    UserService.instance.updateProfile(imageUrl: urlImage);
    if (kDebugMode) {
      print("sukses upload image");
    }
    setState(() {});
  }
}
