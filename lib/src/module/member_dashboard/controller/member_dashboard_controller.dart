import 'dart:convert';

import 'package:cassiere/core.dart';
import 'package:cassiere/src/shared/utils/info_dialog_reverse.dart';
import 'package:flutter/material.dart';

class MemberDashboardController extends State<MemberDashboardView> {
  static late MemberDashboardController instance;
  late MemberDashboardView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  scanQrCode() async {
    var qrCode = await showQrcodeScanner();
    var obj = jsonDecode(qrCode);
    // log(obj.toString());
    if (obj == null) return;
    await PointService.addPoint(
      point: double.parse("${obj["point"] ?? 0}"),
      total: double.parse("${obj["total"] ?? 0}"),
    );
    // showInfoDialog("Congratulation !!! you get \n ${obj["point"]} points");
    infoDialogReverse(
        title: "Congratulation \n You have ${obj["point"].toInt()} point");
  }
}
