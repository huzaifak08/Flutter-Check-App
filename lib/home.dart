import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '';
  final barCodeScanner = GoogleMlKit.vision.barcodeScanner();

  void scanBarcode() async {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      var file = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.camera);

      setState(() {
        text = 'Processing...';
      });

      final visionImage = InputImage.fromFilePath(file!.path);

      var barcodeText = await barCodeScanner.processImage(visionImage);

      for (Barcode barcode in barcodeText) {
        setState(() {
          text = barcode.displayValue!;
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(height: 10),
            IconButton(
                onPressed: () {
                  scanBarcode();
                },
                icon: const Icon(Icons.camera))
          ],
        ),
      ),
    );
  }
}
