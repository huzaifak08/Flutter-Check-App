import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/API%20Services/API%20Example%20APP/signup_api.dart';
import 'package:test_app/Add%20to%20Cart/cart_provider.dart';
import 'package:test_app/Firestore/home.dart';
import 'package:test_app/Providers/count_provider.dart';
import 'package:test_app/Providers/count_screen.dart';
import 'package:test_app/Shared%20Preferences/shared_preferences_widget.dart';
import 'package:test_app/Splash/splash_page.dart';
import 'package:test_app/Routes%20Services/route_name.dart';
import 'package:test_app/Routes%20Services/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        home: const SharedPreferencesWidget(),
        // initialRoute: RouteName.firstScreen,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
