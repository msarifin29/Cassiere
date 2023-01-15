import 'package:flutter/material.dart';
import '../view/point_history_view.dart';

class PointHistoryController extends State<PointHistoryView> {
  static late PointHistoryController instance;
  late PointHistoryView view;

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
