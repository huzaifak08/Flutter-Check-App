import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Services/database_service.dart';
import 'package:test_app/Firestore/home.dart';
import 'package:test_app/Widgets/widgets.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(hintText: 'Product Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: productPriceController,
              decoration: const InputDecoration(hintText: 'Product Price'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                DatabaseService()
                    .createProductData(
                        productNameController.text,
                        FirebaseAuth.instance.currentUser!.uid,
                        productPriceController.text)
                    .then((value) {
                  toastMessage('Data Saved Complete');
                  nextScreenReplacement(context, const HomePage());
                }).onError((error, stackTrace) {
                  toastMessage(error.toString());
                  debugPrint(error.toString());
                });

                // DatabaseService()
                //     .saveProductData(FirebaseAuth.instance.currentUser!.uid,
                //         productNameController.text, productPriceController.text)
                //     .then((value) {
                //   toastMessage('Data Saved Complete');
                //   nextScreenReplacement(context, const HomePage());
                // }).onError((error, stackTrace) {
                //   toastMessage(error.toString());
                //   debugPrint(error.toString());
                // });

                // DatabaseService()
                //     .addProductData(FirebaseAuth.instance.currentUser!.uid, {
                //   'productName': productNameController.text,
                //   'productPrice': productPriceController.text,
                // }).then((value) {
                //   toastMessage('Data Saved Complete');
                //   nextScreenReplacement(context, const HomePage());
                // }).onError((error, stackTrace) {
                //   toastMessage(error.toString());
                //   debugPrint(error.toString());
                // });

                // DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                //     .createProdct(
                //         productNameController.text, productPriceController.text)
                //     .then((value) {
                //   toastMessage('Data Saved Complete');
                //   nextScreenReplacement(context, const HomePage());
                // }).onError((error, stackTrace) {
                //   toastMessage(error.toString());
                //   debugPrint(error.toString());
                // });
              },
              child: const Text('Save Data'),
            )
          ],
        ),
      ),
    );
  }
}
