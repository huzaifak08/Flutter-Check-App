import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class FlutterEncDec extends StatefulWidget {
  const FlutterEncDec({super.key});

  @override
  State<FlutterEncDec> createState() => _FlutterEncDecState();
}

class _FlutterEncDecState extends State<FlutterEncDec> {
  final passwordController = TextEditingController();

  String? encrptedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('encryption/Decryption')),
      body: Column(
        children: [
          TextField(
            controller: passwordController,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                final password = 'mypassword';
                final encryptionKey = base64.encode(
                    List.generate(16, (_) => Random.secure().nextInt(256)));

                print('Encrypted Key: ' + encryptionKey);

                encryptString(passwordController.text, encryptionKey);

                setState(() {});
              },
              child: Text('Encrypt')),
          ElevatedButton(onPressed: () {}, child: Text('Decrypt')),
          Text(encrptedText ?? ''),
        ],
      ),
    );
  }

  encryptString(String plaintext, String keyString) {
    final key = encrypt.Key.fromUtf8(keyString);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    final encryptedBase64 = base64.encode(encrypted.bytes);
    final encryptedHex = hex.encode(encrypted.bytes);

    if (encrypted.bytes.length % 2 == 0) {
      final encryptedHex = hex.encode(encrypted.bytes);
    }
    print('Encrypted base64: $encryptedBase64'); // recommended
    encrptedText = encryptedBase64;

    print('Encrypted hex: $encryptedHex');
  }
}
