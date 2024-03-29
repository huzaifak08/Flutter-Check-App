import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final toController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sending Email"),
      ),
      body: Column(
        children: [
          TextField(
            controller: toController,
            decoration: const InputDecoration(labelText: 'To'),
          ),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(labelText: 'Body'),
            maxLines: 4,
          ),
          ElevatedButton(
            onPressed: () {
              sendMail(
                  recipientEmail: toController.text,
                  mailMessage: messageController.text);
            },
            child: const Text('Send Email'),
          )
        ],
      ),
    );
  }

  void sendMail(
      {required String recipientEmail, required String mailMessage}) async {
    String username = 'hk7928042@gmail.com';

    String password = 'password';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Mail Service')
      ..recipients.add(recipientEmail)
      ..subject = 'Mail'
      ..text = 'Message $mailMessage';

    try {
      await send(message, smtpServer);
      debugPrint("Email Send Successfully");
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
