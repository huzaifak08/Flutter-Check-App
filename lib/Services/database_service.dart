import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for our collections:
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  // Save the user data:

  Future saveUserDataInDatabase(
      String fullName, String email, String password) async {
    return await usersCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "products": [],
      "profile_pic": "",
      "uid": uid,
      "password": password
    });
  }

  // Getting the User Specific data according to email:
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await usersCollection.where('email', isEqualTo: email).get();

    return snapshot;
  }

  // Save Method 1:
  Future createProductData(
      String productName, String userId, String productDescription) async {
    DocumentReference productDocumentReference = await productCollection.add({
      "productName": productName,
      "productDescription": productDescription,
      "userId": userId,
      "admin": "${userId}_$productName",
      "productId":
          "", // This will be generate after the execution of this method so we have to update this after this method
    });

    // Update the members:
    await productDocumentReference.update({
      "productId": productDocumentReference.id,
    });

    // Update the group in Users Collections Also:
    DocumentReference userDocumentReference = usersCollection.doc(userId);
    return await userDocumentReference.update({
      "products":
          FieldValue.arrayUnion(["${productDocumentReference.id}_$productName"])
    });
  }

  // Save Method 2:
  Future<void> saveProductData(
      String userId, String productName, String productDescription) async {
    await productCollection.add({
      'userId': userId,
      'name': productName,
      'description': productDescription,
    });

    DocumentReference userDocumentReference = usersCollection.doc(userId);
    return await userDocumentReference.update({
      "products": FieldValue.arrayUnion([productName])
    });
  }

  // get:

  Stream<QuerySnapshot> getUserProductData(String userId) {
    return productCollection.where('userId', isEqualTo: userId).snapshots();
  }

  // Update Data:
  Future<void> updateProdctData(
      String productId, String productName, String productDescription) {
    return productCollection.doc(productId).update({
      'productName': productName,
      'productDescription': productDescription,
    });
  }

  // Delete Data:

  Future<void> deleteProductData(
      String userId, String productId, String productName) async {
    // delete from product collection:
    await productCollection.doc(productId).delete();

    // also delete from users collection:
    DocumentReference userDocumentReference = usersCollection.doc(userId);
    return await userDocumentReference.update({
      "products": FieldValue.arrayRemove(["${productId}_$productName"])
    });
  }
}
