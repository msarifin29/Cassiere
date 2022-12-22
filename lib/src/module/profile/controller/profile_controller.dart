import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

class ProfileController extends State<ProfileView> implements MvcController {
  static late ProfileController instance;
  late ProfileView view;
  late TextEditingController userController;

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

  doLogout() async {
    await AuthService.doLogout();
    Get.offAll(const LoginView());
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
        void submit() {
          Navigator.of(context).pop(userController.text);
        }

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: submit,
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
    await UserService.editUserName(name);
  }

  void editUserPhoto() async {
    const String url =
        "https://firebasestorage.googleapis.com/v0/b/cassiere-7a631.appspot.com/o/images?alt=media&token=9ee63dde-2fd2-4331-be78-9cf545894454";
    await UserService.uploadPhoto();
    await UserService.editPhoto(photo: url);
    setState(() {});
  }
}
