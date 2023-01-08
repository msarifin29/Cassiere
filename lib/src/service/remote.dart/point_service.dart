import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cassiere/src/service/remote.dart/user_service.dart';
import 'package:flutter/foundation.dart';

class PointService {
  static addPoint({
    required double point,
    required double total,
  }) async {
    await FirebaseFirestore.instance.collection("points").add({
      "point": point,
      "total": total,
      "user": UserService.instance.getUserData(),
    });
    if (kDebugMode) {
      print("Add point success!");
    }
    await UserService.instance.updatePoint(
      point: point,
    );
    if (kDebugMode) {
      print("Update point success!");
    }
  }
}
