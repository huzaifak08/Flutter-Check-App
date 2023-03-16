import 'package:flutter/material.dart';
import 'package:test_app/API%20Services/api_complex_json.dart';
import 'package:test_app/API%20Services/api_custom_model.dart';
import 'package:test_app/Firestore/home.dart';
import 'package:test_app/Widgets/widgets.dart';

import '../API Services/api_page.dart';

class CustomDrawer extends StatelessWidget {
  final int index;
  const CustomDrawer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            _createDrawerItem(
                isSelected: index == 0 ? true : false,
                icon: Icons.home,
                text: 'Home Firestore',
                onTap: () {
                  nextScreenReplacement(context, const HomePage());
                }),
            _createDrawerItem(
                isSelected: index == 1 ? true : false,
                icon: Icons.api,
                text: 'API Page',
                onTap: () {
                  nextScreenReplacement(context, const APIScreen());
                }),
            _createDrawerItem(
                isSelected: index == 2 ? true : false,
                icon: Icons.api_outlined,
                text: 'API Custom Model',
                onTap: () {
                  nextScreenReplacement(context, const APICustomModel());
                }),
            _createDrawerItem(
                isSelected: index == 3 ? true : false,
                icon: Icons.api_outlined,
                text: 'API Complex JSON',
                onTap: () {
                  nextScreenReplacement(context, const APIComplexScreen());
                }),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem(
      {required bool isSelected,
      required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      title: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
