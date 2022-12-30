import 'package:flutter/material.dart';
import 'package:cassiere/state_util.dart';
import '../view/main_member_view.dart';

class MainMemberController extends State<MainMemberView>
    implements MvcController {
  static late MainMemberController instance;

  late MainMemberView view;

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
