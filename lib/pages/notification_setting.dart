import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool available = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body: Container(
        padding: cupertino.EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainHeadingText(
                  text: 'App Notification',
                  color: MyColors.blackColor,
                  fontSize: 18,
                ),
                cupertino.CupertinoSwitch(

                  value: available,
                  onChanged: (value) {
                    available = value;
                    setState(() {});
                  },
                  activeColor: MyColors.primaryColor,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainHeadingText(
                  text: 'Notification',
                  color: MyColors.blackColor,
                  fontSize: 18,
                ),
                cupertino.CupertinoSwitch(

                  value: available,
                  onChanged: (value) {
                    available = value;
                    setState(() {});
                  },
                  activeColor: MyColors.primaryColor,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
