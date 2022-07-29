import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import '../main.dart';

class BottomNavBarWidgetLogin extends StatefulWidget {
  @override
  _BottomNavBarWidgetLoginState createState() => _BottomNavBarWidgetLoginState();
}

class _BottomNavBarWidgetLoginState extends State<BottomNavBarWidgetLogin> {
  @override
  Widget build(BuildContext context) {
    
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
       // navigateToScreens(index);
        print("OnSelected"+ _selectedIndex.toString());
      });
    }

    return BottomNavigationBar(
      backgroundColor: Colors.cyan[400],
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
