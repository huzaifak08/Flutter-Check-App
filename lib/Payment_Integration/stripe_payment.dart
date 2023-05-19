import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePayment extends StatefulWidget {
  const StripePayment({super.key});

  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stripe Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                makePayment();
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }

  // Make Payments:
  void makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent();

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
        style: ThemeMode.dark,
        merchantDisplayName: 'Huzaifa',
      ));

      displayPaymentSheet();
    } catch (e) {
      // ignore: avoid_print
      print('Exception ${e.toString()}');
    }
  }

  // Create Payment Intent:
  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {'amount': '1000', 'currency': 'USD'};

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51MpwQYDN9fTnljaFTXbhWS1zEGVt4wp0K5Hcih6BO1MUH7lZDhcSY4TbJ7zy1zCsaBluHAoG6QTHx9SlIHhXkGTZ008pqOGsRk',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body);
    } catch (e) {
      // ignore: avoid_print
      print('Exception ${e.toString()}');
    }
  }

  // Display Payment Sheet:
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('done');
      // setState(() {
      //   paymentIntentData = null;
      // });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('paid')));
    } on StripeException catch (e) {
      // ignore: avoid_print
      print('Exception ${e.toString()}');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('cancelled'),
        ),
      );
    }
  }
}
