import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cassiere/state_util.dart';

Future infoDialog({required String title, Function()? onContinue}) {
  return AwesomeDialog(
          context: globalContext,
          dialogType: DialogType.infoReverse,
          headerAnimationLoop: true,
          animType: AnimType.bottomSlide,
          title: title,
          btnOkText: "Yes",
          btnCancelText: "No",
          reverseBtnOrder: true,
          btnCancelOnPress: () {},
          btnOkOnPress: onContinue,
          desc: "")
      .show();
}
