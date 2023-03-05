import 'package:flutter/material.dart';
import 'package:test_app/Services/database_service.dart';
import 'package:test_app/widgets.dart';

class UpdateScreen extends StatefulWidget {
  String productId;
  String oldProductName;
  String oldProductDescription;
  UpdateScreen({
    super.key,
    required this.productId,
    required this.oldProductName,
    required this.oldProductDescription,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final productNameController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Show Old values in TextField by default:
    productNameController.text = widget.oldProductName;
    productPriceController.text = widget.oldProductDescription;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Page'),
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
                // Update Operation:

                DatabaseService()
                    .updateProdctData(widget.productId,
                        productNameController.text, productPriceController.text)
                    .then((value) {
                  toastMessage('Update Done');
                  Navigator.pop(context);
                }).onError((error, stackTrace) {
                  toastMessage(error.toString());
                });
              },
              child: const Text('Update Data'),
            )
          ],
        ),
      ),
    );
  }
}
