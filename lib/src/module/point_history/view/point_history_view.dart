import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class PointHistoryView extends StatefulWidget {
  const PointHistoryView({Key? key}) : super(key: key);

  Widget build(context, PointHistoryController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("points").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something wrong...!"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data!.docs[index].data();
                final point = data["point"].toInt();
                final totalPayment = data["total"].toDouble();

                final time = DateTime.fromMicrosecondsSinceEpoch(
                    data["date"].microsecondsSinceEpoch);
                String formattedDate = DateFormat.yMMMd().format(time);

                return Card(
                    child: Padding(
                  padding: const EdgeInsets.all(AppSize.s12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Total payment : Rp. ${NumberFormat.currency(locale: 'ID', symbol: "", decimalDigits: 0).format(totalPayment)}"),
                      Text("point : $point"),
                      Text("date : $formattedDate"),
                    ],
                  ),
                ));
              },
            );
          }),
    );
  }

  @override
  State<PointHistoryView> createState() => PointHistoryController();
}
