import 'package:flutter/material.dart';
import '../view/sales_view.dart';

class SalesController extends State<SalesView> {
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
