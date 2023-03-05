import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/Auth%20Screens/login_page.dart';
import 'package:test_app/Services/auth_service.dart';
import 'package:test_app/Services/database_service.dart';
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
                        // DatabaseService()
                        //     .deleteProductDataFromUser(
                        //         FirebaseAuth.instance.currentUser!.uid,
                        //         productData['productId'],
                        //         productData['productName']
                        // )
                        //     .then((value) {
                        //   toastMessage('Item deleted');
                        // }).onError((error, stackTrace) {
                        //   toastMessage(error.toString());
                        // });

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

                        // DatabaseService()
                        //     .deleteProductData(productData['productId'])
                        //     .then((value) {
                        //   toastMessage('Item deleted');
                        // }).onError((error, stackTrace) {
                        //   toastMessage(error.toString());
                        // });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );

            // Map<String, dynamic> data =
            //     snapshot.data!.data() as Map<String, dynamic>;
            // return Text('Hello ${data['productName']}!');

            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     return Column(
            //       children: [
            //         ListTile(
            //           title: Text(snapshot.data!.docs[index]['productName']),
            //           subtitle:
            //               Text(snapshot.data!.docs[index]['productPrice']),
            //         )
            //       ],
            //     );
            //   },
            // );

            // return ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data() as Map<String, dynamic>;
            //     return ListTile(
            //       title: Text(data['productName']),
            //       // subtitle: Text(data['price']),
            //     );
            //   }).toList(),
            // );

            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     DocumentSnapshot userData = snapshot.data!.docs[index];
            //     return ListTile(
            //       title: Text(userData['productName']),
            //       subtitle: Text(userData['productPrice']),
            //     );
            //   },
            // );
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
