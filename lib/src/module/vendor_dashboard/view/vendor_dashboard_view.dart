import 'package:cassiere/src/shared/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cassiere/core.dart';

import '../widget/custom_text_icon.dart';

class VendorDashboardView extends StatefulWidget {
  const VendorDashboardView({Key? key}) : super(key: key);

  Widget build(context, VendorDashboardController controller) {
    controller.view = this;

    String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cassiere"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: GridView.count(
              crossAxisCount: 2,
              // primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: AppSize.s30,
              mainAxisSpacing: AppSize.s30,
              children: [
                CustomTextIcon(
                  text: "Account",
                  icon: MdiIcons.accountCircleOutline,
                  onTap: () => Get.to(
                    const ProfileView(),
                  ),
                ),
                CustomTextIcon(
                    text: "Sales",
                    icon: MdiIcons.saleOutline,
                    onTap: () {
                      Get.to(const SalesView());
                    }),
                CustomTextIcon(
                  text: "Casir",
                  icon: MdiIcons.storefrontCheckOutline,
                  onTap: () => Get.to(
                    const PosView(),
                  ),
                ),
                CustomTextIcon(
                  text: "Catalog",
                  icon: MdiIcons.viewDashboardOutline,
                  onTap: () => Get.to(
                    const ProductListView(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: AppSize.s50,
          margin: const EdgeInsets.symmetric(
              horizontal: AppSize.s8, vertical: AppSize.s12),
          decoration: BoxDecoration(
              color: AppColor.appBarColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(AppSize.s12)),
          alignment: Alignment.center,
          child: Text(
            formattedDate,
            style: GoogleFonts.bebasNeue(
                textStyle: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColor.whiteColor)),
          )),
    );
  }

  @override
  State<VendorDashboardView> createState() => VendorDashboardController();
}

// class CustomCardVendor extends StatelessWidget {
//   const CustomCardVendor({
//     Key? key,
//     this.onTap,
//   }) : super(key: key);

//   final Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: Get.height * 0.3,
//       child: Card(
//         color: AppColor.cardColor,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const CardProfileUser(),
//             Container(
//               width: Get.width * 0.3,
//               margin: const EdgeInsets.symmetric(
//                 vertical: AppSize.s12,
//                 horizontal: AppSize.s12,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(AppSize.s12),
//                 color: AppColor.whiteColor,
//               ),
//               child: InkWell(
//                 onTap: onTap,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       MdiIcons.qrcode,
//                       size: AppSize.s50,
//                       color: AppColor.blackColor,
//                     ),
//                     Text(
//                       "Scan QRCode",
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             color: AppColor.blackColor,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
