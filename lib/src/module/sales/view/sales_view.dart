import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';
import '../controller/sales_controller.dart';

class SalesView extends StatefulWidget {
  const SalesView({Key? key}) : super(key: key);

  Widget build(context, SalesController controller) {
    controller.view = this;

    return Scaffold(
        appBar: AppBar(
          title: const Text("sales report"),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            "sales report",
            style: Theme.of(context).textTheme.headline5,
          ),
        ));
  }

  @override
  State<SalesView> createState() => SalesController();
}
