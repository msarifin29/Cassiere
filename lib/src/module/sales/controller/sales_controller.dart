import 'package:cassiere/state_util.dart';
import 'package:flutter/material.dart';
import '../view/category_list_view.dart';

class SalesController extends State<SalesView> implements MvcController {
  static late SalesController instance;
  late SalesView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
