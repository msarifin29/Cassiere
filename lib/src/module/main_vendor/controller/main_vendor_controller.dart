import 'package:flutter/material.dart';
import 'package:cassiere/state_util.dart';
import '../view/main_vendor_view.dart';

class MainVendorController extends State<MainVendorView>
    implements MvcController {
  static late MainVendorController instance;
  late MainVendorView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
  int selectedIndex = 0;
}
