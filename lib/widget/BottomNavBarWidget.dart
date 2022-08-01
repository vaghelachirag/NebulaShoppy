import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:page_transition/page_transition.dart';
import '../main.dart';
import '../screen/search.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
       //ßßß navigateToScreens(index);
        print("OnSelected"+ _selectedIndex.toString());
      });
    }

    return  BottomNavigationBar(
      backgroundColor: Colors.cyan[400],
      type: BottomNavigationBarType.fixed,
      
      
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.shippingFast),
          label: 'My Order',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Account',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      
      onTap: (value) {
           print("OnTap"+  "OnTap");
           _onItemTapped(value);
          _selectedIndex = 1;
          setState(() {});
        },
    );
  }
}
