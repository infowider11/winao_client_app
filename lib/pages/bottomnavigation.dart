/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has four [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.shifting], and
// the [currentIndex] is set to index 0. The selected item is amber in color.
// With each [BottomNavigationBarItem] widget, backgroundColor property is
// also defined, which changes the background color of [BottomNavigationBar],
// when that item is selected. The `_onItemTapped` function changes the
// selected item's index and displays a corresponding message in the center of
// the [Scaffold].

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/global_keys.dart';
import 'package:winao_client_app/pages/home.dart';
import 'package:winao_client_app/pages/myorder.dart';
import 'package:winao_client_app/pages/notification.dart';
import 'package:winao_client_app/pages/settings.dart';

const themecolor = Color(0xFF6699c8);

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {


  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: _title,
      home: MyStatefulWidget(key: MyGlobalKeys.tabBarKey,),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  static const String id="bottomnavigation";
  const MyStatefulWidget({required Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  bool isExit=false;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[

    Home(),
    NotificationPage(),
    MyorderPage(),
    SettingsPage(),
    // Itemlisting(),

  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(context: context, builder: (context1){
          return AlertDialog(

            title: Text('Exit',),
            content: Text('Are you sure, want to Exit?'),
            actions: [
              TextButton(
                  onPressed: () async {
                    // Navigator.pop(context1);
                    //
                    // isExit=true;
                    //         setState(() {
                    //
                    //         });
                    SystemNavigator.pop();
                  }, child: Text('Exit')),
              TextButton(onPressed: () async {

                Navigator.pop(context1);
                // isExit=false;
                // setState(() {
                //
                // });
              }, child: Text('cancel')
              ),
            ],
          );
        });

        if(isExit){
          return true;
        }
        else{
          return false;
        }
      },
      child: Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/home.png"),
                color: Color(0xFF000000),
              ),
              activeIcon:Container(
                width: MediaQuery.of(context).size.width,
                // color: MyColors.redColor,
                child: ImageIcon(
                  AssetImage("assets/icons/home.png",),
                  // color: Color(0xFF3A5A98),
                ),
              ),
              // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
              // icon: Icon(Icons.home, size: 30,color: Colors.black,),
              label: '',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
                label: 'exd',
                backgroundColor: Colors.red,
                // activeIcon: Icon(Icons.home, size: 30,color: themecolor,),
                activeIcon: Stack(
                  children: <Widget>[
                    // Icon(Icons.shopping_cart, size: 30, color: themecolor,),
                    ImageIcon(
                      AssetImage("assets/icons/notification.png"),
                      // color: Color(0xFF000000),
                      size: 25,
                    ),

                  ],
                ),
                icon: Stack(
                  children: <Widget>[

                    ImageIcon(
                      AssetImage("assets/icons/notification.png"),
                      color: Color(0xFF000000),
                      size: 25,
                    ),

                  ],
                )
            ),
            BottomNavigationBarItem(
              // icon: Icon(Icons.school, size: 30, color: Colors.black,),
              icon: ImageIcon(
                AssetImage("assets/icons/order.png"),
                color: Color(0xFF000000),
                size: 25,
              ),
              activeIcon: ImageIcon(
                AssetImage("assets/icons/order.png"),
                // color: Color(0xFF000000),
                size: 25,
              ),
              label: '',
              backgroundColor: Colors.white,
            ),
            const BottomNavigationBarItem(
              // icon: Icon(Icons.settings, size: 30,color: Colors.black,),
              // activeIcon: Icon(Icons.settings, size: 30,color: themecolor,),
              icon: ImageIcon(
                AssetImage("assets/icons/setting.png"),
                color: Color(0xFF000000),
                size: 22,
              ),
              activeIcon: ImageIcon(
                AssetImage("assets/icons/setting.png"),
                // color: Color(0xFF000000),
                size: 22,
              ),
              label: '',
              backgroundColor: MyColors.primaryColor,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MyColors.primaryColor,
          // backgroundColor: MyColors.primaryColor,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}

