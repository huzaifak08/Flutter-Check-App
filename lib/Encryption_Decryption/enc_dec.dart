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

  final encryptionKey =
      base64.encode(List.generate(16, (_) => Random.secure().nextInt(256)));

  String? encrptedText;
  String? decryptedText;

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
                print('Encrypted Key: ' + encryptionKey);

                encryptString(passwordController.text, encryptionKey);

                setState(() {});
              },
              child: const Text('Encrypt')),
          ElevatedButton(
              onPressed: () {
                final decryptedText =
                    decryptString(encrptedText!, encryptionKey);
                print('Decrypted text: $decryptedText');

                setState(() {});
              },
              child: Text('Decrypt')),
          SizedBox(height: 12),
          Text('Encrypted Text: ${encrptedText ?? ''}'),
          Text('Decrypted Text: ${decryptedText ?? ''}'),
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

  // Decryption:
  String decryptString(String encryptedBase64, String keyString) {
    final key = encrypt.Key.fromUtf8(keyString);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypt.Encrypted.fromBase64(encryptedBase64);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    decryptedText = decrypted;

    return decrypted;
  }
}
