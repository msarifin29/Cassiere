import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cassiere/state_util.dart';

Future infoDialogReverse({String? title, String? desc}) {
  return AwesomeDialog(
          context: globalContext,
          dialogType: DialogType.success,
          headerAnimationLoop: true,
          animType: AnimType.bottomSlide,
          title: title,
          reverseBtnOrder: true,
          autoHide: const Duration(seconds: 5),
          // btnOkOnPress: () {},
          // btnCancelOnPress: () {},
          desc: desc)
      .show();
}
