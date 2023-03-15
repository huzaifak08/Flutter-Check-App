import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/API%20Services/api_custom_model.dart';
import 'package:test_app/Auth%20Screens/login_page.dart';
import 'package:test_app/Notification/notification_services.dart';
import 'package:test_app/Services/auth_service.dart';
import 'package:test_app/Services/database_service.dart';
import 'package:test_app/API%20Services/api_page.dart';
import 'package:test_app/create_page.dart';
import 'package:test_app/update_page.dart';
import 'package:test_app/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission(); // Permisson:

    // Token:
    notificationServices.getDeviceToken().then((value) {
      debugPrint('Value: ');
      debugPrint(value);
    });

    // Refresh:
    notificationServices.isTokenRefresh();

    notificationServices.firebaseInit(context);

    notificationServices.setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                authService.signOut().whenComplete(() {
                  toastMessage('Sign Out complete');
                  nextScreenReplacement(context, const LoginPage());
                });
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const ListTile(
                title: Text('Firebase Page'),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: const Text('API Page'),
                leading: const Icon(Icons.api),
                onTap: () {
                  nextScreenReplacement(context, const APIScreen());
                },
              ),
              ListTile(
                title: const Text('API Custom Model'),
                leading: const Icon(Icons.api_outlined),
                onTap: () {
                  nextScreenReplacement(context, const APICustomModel());
                },
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: DatabaseService()
            .getUserProductData(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            final productDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: productDocs.length,
              itemBuilder: (context, index) {
                final productData =
                    productDocs[index].data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: () {
                    nextScreen(
                        context,
                        UpdateScreen(
                          productId: productData['productId'],
                          oldProductName: productData['productName'],
                          oldProductDescription:
                              productData['productDescription'],
                        ));
                  },
                  child: ListTile(
                    title: Text(productData['productName']),
                    subtitle: Text(productData['productDescription']),
                    trailing: IconButton(
                      onPressed: () {
                        DatabaseService()
                            .deleteProductData(
                                FirebaseAuth.instance.currentUser!.uid,
                                productData['productId'],
                                productData['productName'])
                            .then((value) {
                          toastMessage('Item deleted');
                        }).onError((error, stackTrace) {
                          toastMessage(error.toString());
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No Data'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreatePage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Stream<QuerySnapshot> getUserProductData(String userId) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
}
