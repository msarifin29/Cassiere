import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

class PosView extends StatefulWidget {
  const PosView({Key? key}) : super(key: key);

  Widget build(context, PosController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.8,
            child: ListView.builder(
              itemCount: controller.listProduct.length,
              itemBuilder: (context, index) {
                var item = controller.listProduct[index];
                // item["qty"] = item["qty"] ?? 0;

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      backgroundImage: NetworkImage(
                        item.image,
                      ),
                    ),
                    title: Text(item.title),
                    subtitle: Text("${item.price} USD"),
                    trailing: SizedBox(
                      width: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 12.0,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // item["qty"]--;
                                  controller.setState(() {});
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 9.0,
                                ),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "0",
                              // "${item["qty"]}",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            radius: 12.0,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // item["qty"]++;
                                  controller.setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 9.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(MdiIcons.checkCircle),
              label: const Text("Checkout"),
              onPressed: () => controller.doCheckout(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<PosView> createState() => PosController();
}
