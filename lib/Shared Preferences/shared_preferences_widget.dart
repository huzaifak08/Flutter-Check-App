import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWidget extends StatefulWidget {
  const SharedPreferencesWidget({super.key});

  @override
  State<SharedPreferencesWidget> createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  String? name;
  int? age;
  double? lucky_number;
  bool? isLogin;

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  void getStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.getBool('isLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shared Preferences Widget')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name!),
          Text(age.toString()),
          Text(lucky_number.toString()),
          Text(isLogin.toString()),

          // Getting data straight from future builder without init state or any other method:
          Expanded(
            child: FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                return Column(
                  children: [
                    Text(snapshot.data!.getString('name').toString()),
                    Text(snapshot.data!.getInt('age').toString()),
                    Text(snapshot.data!.getDouble('lucky_number').toString()),
                    Text(snapshot.data!.getBool('isLogin').toString()),
                  ],
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();

          sp.setInt('age', 20);
          sp.setDouble('lucky_number', 20.2);
          sp.setString('name', 'Huzaifa');
          sp.setBool('isLogin', true);

          print(sp.getInt('age'));
          print(sp.getDouble('lucky_number'));
          print(sp.getString('name'));
          print(sp.getBool('isLogin'));

          setState(() {
            name = sp.getString('name');
            age = sp.getInt('age');
            lucky_number = sp.getDouble('lucky_number');
            isLogin = sp.getBool('isLogin');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
