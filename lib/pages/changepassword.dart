import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winao_client_app/constants/colors.dart';
import 'package:winao_client_app/constants/sized_box.dart';
import 'package:winao_client_app/widgets/CustomTexts.dart';
import 'package:winao_client_app/widgets/appbar.dart';
import 'package:winao_client_app/widgets/customtextfield.dart';
import 'package:winao_client_app/widgets/round_edged_button.dart';

import '../services/api_urls.dart';
import '../services/auth.dart';
import '../services/webservices.dart';
import '../widgets/loader.dart';
import '../widgets/showSnackbar.dart';

class ChangePassword extends StatefulWidget {
  static const String id="change";
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController codeController = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController new_pass = TextEditingController();
  final TextEditingController confirm_pass = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context: context),
      body:

          Stack(
            children: [
              SingleChildScrollView(
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainHeadingText(
                        text: 'Change Password',
                        color: MyColors.blackColor,
                        textAlign: TextAlign.left,
                        fontSize: 18,
                        fontFamily: 'Regular',
                      ),
                      vSizedBox,
                      CustomTextField(controller: password,obscureText: true, hintText: 'Old Password', prefixIcon: 'assets/images/key.png',),
                      CustomTextField(controller: new_pass,obscureText: true, hintText: 'New Password', prefixIcon: 'assets/images/key.png',),
                      CustomTextField(controller: confirm_pass,obscureText: true, hintText: 'Confirm Password', prefixIcon: 'assets/images/key.png',),
                      vSizedBox,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                 child: RoundEdgedButtonred(text: 'Change Password',
                   color: MyColors.primaryColor,
                   onTap:   () async {
                     String pattern =
                         r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$';

                     RegExp regex = new RegExp(pattern);
                     if (password.text == '') {
                       showSnackbar(context, 'Please Enter your password.');
                     }

                     else if (password.text == '') {
                       showSnackbar(context, 'Please Enter your new password.');
                     }
                     else if (!regex.hasMatch(new_pass.text)) {
                       showSnackbar(context, 'Password must have minimum letters one uppercase numbers and one special character.');
                     }
                     else if (confirm_pass.text == '') {
                       showSnackbar(context, 'Please Enter your confirm password.');
                     }
                     else if (confirm_pass.text != new_pass.text) {
                       showSnackbar(context, 'Confirm Password and New password should be same.');
                     }
                     else {
                       Map<String, dynamic> data = {
                         'user_id':await getCurrentUserId(),
                         'current_password': password.text,
                         'password': new_pass.text,
                       };
                       loadingShow(context);
                       var res = await Webservices.postData(
                           apiUrl: ApiUrls.change_password,
                           body: data,
                           context: context,
                           showSuccessMessage: true);
                       loadingHide(context);
                       print("Api response" + res.toString());
                       if (res['status'].toString() == '1') {
                         Navigator.pop(context);
                       }
                     }
    // print('user data----$user_data');


    }
    // push(context: context, screen: UploadPicPage());
                   // ,


                 ),

                )
              ),
            ],
          )





    );
  }
}
