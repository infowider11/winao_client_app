import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/pages/general_information.dart';
import 'package:winao_client_app/pages/privacyandpolicy.dart';
import 'package:winao_client_app/pages/terms.dart';
import 'package:winao_client_app/widgets/appbar.dart';

class HelpPage extends StatefulWidget {
  static const String id="noti";
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => trems()
                ));
              },
              // leading: SizedBox(
              //     height: 25.0,
              //     width: 25.0, // fixed width and height
              //     child: Image.asset('assets/icons/account.png')
              // ),
              // contentPadding: EdgeInsets.all(0),

              title: Transform.translate(
                offset: const Offset(-10.0, 0.0),
                child:
                Text('Terms and Conditions',
                  style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'regular'),),
              ),
              trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
            ),
            Divider(
              color: Color(0xFFDDDDDD),
              thickness: 1,
              height: 10,
            ),

            ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => GeneralInformation()
                  ));
                },
                // leading: SizedBox(
                //     height: 25.0,
                //     width: 25.0, // fixed width and height
                //     child: Image.asset('assets/icons/account.png')
                // ),
                // contentPadding: EdgeInsets.all(0),

                title: Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child:
                  Text('About Us',
                    style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'regular'),),
                ),
                trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
            ),
            Divider(
              color: Color(0xFFDDDDDD),
              thickness: 1,
              height: 10,
            ),


            ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => privacy()
                  ));
                },
                // leading: SizedBox(
                //     height: 25.0,
                //     width: 25.0, // fixed width and height
                //     child: Image.asset('assets/icons/account.png')
                // ),
                // contentPadding: EdgeInsets.all(0),

                title: Transform.translate(
                  offset: const Offset(-10.0, 0.0),
                  child:
                  Text('Privacy and policy',
                    style: TextStyle(color: MyColors.blackColor, fontSize: 18, fontFamily: 'regular'),),
                ),
                trailing: Icon(Icons.chevron_right_outlined, size: 20,color: Colors.black,)
            ),
            Divider(
              color: Color(0xFFDDDDDD),
              thickness: 1,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
