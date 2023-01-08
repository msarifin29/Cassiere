import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentReference get userCollection {
  final userId = FirebaseAuth.instance.currentUser!;
  return FirebaseFirestore.instance.collection("users").doc(userId.uid);
}

class UserService {
  UserService._();
  static final UserService instance = UserService._();
  factory UserService() => instance;

  Future<void> createUserIfNotExists() async {
    var snapshot = await userCollection.get();
    if (!snapshot.exists) {
      await userCollection.set({
        "id": FirebaseAuth.instance.currentUser!.uid,
        "photo": FirebaseAuth.instance.currentUser!.photoURL,
        "email": FirebaseAuth.instance.currentUser!.email,
        "name": FirebaseAuth.instance.currentUser!.displayName,
        "point": 0,
      });
    }
  }

  Future<void> updatePoint({
    required double point,
  }) async {
    await userCollection.update({
      "point": FieldValue.increment(point),
    });
  }

  getUserData() {
    var user = {
      "id": FirebaseAuth.instance.currentUser!.uid,
      "email": FirebaseAuth.instance.currentUser!.email,
      "name": FirebaseAuth.instance.currentUser!.displayName,
    };
    return user;
  }

  Future<void> editUserName(String name) async {
    final data = await userCollection.get();
    if (data.exists) {
      return await userCollection.update({
        "name": name,
      });
    } else {
      return await userCollection.set({
        "name": name,
      });
    }
  }

  // Future<String> pickedImage() async {
  //   final Reference storage = FirebaseStorage.instance.ref();
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: [
  //       "png",
  //       "jpg",
  //     ],
  //     allowMultiple: false,
  //   );
  //   if (result == null) return;
  //   File file = File(result.files.single.path!);
  //   final uploadTask = storage.child('images').putFile(file);
  //   final snapshot = await uploadTask.whenComplete(() {});
  //   final imageUrl = await snapshot.ref.getDownloadURL();
  //   return imageUrl;
  //   if (kDebugMode) {
  //     print("url --------- $imageUrl");
  //   }
  //   try {
  //     await uploadTask;
  //     uploadImage(image: imageUrl);
  //   } on FirebaseException catch (error) {
  //     if (kDebugMode) {
  //       print(error);
  //     }
  //   }
  // }

  Future<void> uploadImage({required String imageUrl}) async {
    final data = await userCollection.get();
    if (data.exists) {
      return await userCollection.update({
        "photo": imageUrl,
      });
    } else {
      return await userCollection.set({
        "photo": imageUrl,
      });
    }
  }
}
