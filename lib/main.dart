import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Add%20to%20Cart/cart_provider.dart';
import 'package:test_app/Payment_Integration/stripe_payment.dart';
import 'package:test_app/Providers/count_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51MpwQYDN9fTnljaFeJz2PtKrrhapWIdGHlsZyL1BhtYHd9rJeZc2CShx86LXNHKHUHT88m9G3RnyMOCjAVgL4jkW00JxfBFT8V';

  // Initialize background notification:
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// Must initialize this for Background Notification:
@pragma('vm:entry-point') // Must Add this:
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => CountProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StripePayment(),
        // initialRoute: RouteName.firstScreen,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
