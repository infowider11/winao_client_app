import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/pages/help.dart';
import 'package:winao_client_app/pages/myorder.dart';
import 'package:winao_client_app/pages/notification_setting.dart';

import 'CustomTexts.dart';
import 'drawer_button.dart';


class SideDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SideDrawer({
    Key? key,
    required this.scaffoldKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox4,
                  ListTile(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => Transaction()
                      // ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/home.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Home',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MyorderPage()
                      ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/order.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('My Orders',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),

                  ListTile(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => Transaction()
                      // ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/referral.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Enter Referral Code',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => NotificationSetting()
                      ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/notification.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Notification',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),

                  ListTile(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => Transaction()
                      // ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/setting.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Settings',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),

                  ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => HelpPage()
                      ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/help.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Help',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),
                  ListTile(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => Transaction()
                      // ));
                    },
                    leading: SizedBox(
                        height: 25.0,
                        width: 25.0, // fixed width and height
                        child: Image.asset('assets/icons/report.png')
                    ),
                    // contentPadding: EdgeInsets.all(0),

                    title: Transform.translate(
                      offset: const Offset(-20.0, 0.0),
                      child:
                      Text('Report',
                        style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'semibold'),),
                    ),
                    // trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
