import 'package:cassiere/core.dart';
import 'package:flutter/material.dart';

class VendorDashboardController extends State<VendorDashboardView> {
  static late VendorDashboardController instance;
  late VendorDashboardView view;

  ScrollController scrollController = ScrollController();

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
